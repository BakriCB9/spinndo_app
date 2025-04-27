import 'dart:convert';

import 'package:app/features/payment/keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../view_model/payments_cubit.dart';
import '../view_model/payments_state.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart' as material;


// تعريف enum طرق الدفع
enum PaymentMethodType {
  klarna,
  paypal,
  mastercard,
  visa,
  maestro,
}

// دالة تجيب الأيقونة حسب طريقة الدفع
IconData getIconForPlan(String? methodType) {
  switch (methodType?.toLowerCase()) {
    case 'visa':
      return Icons.credit_card;
    case 'mastercard':
      return Icons.payment;
    case 'paypal':
      return Icons.account_balance_wallet;
    case 'apple pay':
      return Icons.phone_iphone;
    case 'google pay':
      return Icons.android;
    case 'klarna':
      return Icons.account_balance;
    case 'maestro':
      return Icons.credit_score;
    default:
      return Icons.monetization_on;
  }
}

// دالة تجيب اللون حسب طريقة الدفع
Color getColorForPlan(String? methodType) {
  switch (methodType?.toLowerCase()) {
    case 'visa':
      return Colors.blue;
    case 'mastercard':
      return Colors.red;
    case 'paypal':
      return Colors.indigo;
    case 'apple pay':
      return Colors.grey;
    case 'google pay':
      return Colors.green;
    case 'klarna':
      return Colors.purple;
    case 'maestro':
      return Colors.deepOrange;
    default:
      return Colors.orange;
  }
}

class PaymentsScreen extends StatefulWidget {
  static const String routeName = '/payments';

  const PaymentsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {

  double amount = 20;
  Map<String, dynamic>? intentPaymentData;

  Future<Map<String, dynamic>?> makeIntentForPayment(int amountToBeCharged, String currency) async {
    try {
      Map<String, dynamic> paymentInfo = {
        "amount": amountToBeCharged.toString(), // لاحظ String
        "currency": currency,
        "payment_method_types[]": "card",
      };
      var responseFromStripeAPI = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"), // هنا عدلنا اللينك
        body: paymentInfo,
        headers: {
          "Authorization": "Bearer $SecretKey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );
      print("response from API = ${responseFromStripeAPI.body}");
      return jsonDecode(responseFromStripeAPI.body);
    } catch (errorMsg) {
      if (kDebugMode) {
        print(errorMsg);
      }
      return null;
    }
  }

  showPaymentSheet()async {
    try{
      await Stripe.instance.presentPaymentSheet().then((val){
        intentPaymentData=null;
      }).onError((errorMsg,sTrace){
        if(kDebugMode)
        {
          print(errorMsg.toString()+sTrace.toString());
        }
      });
    }
    on StripeException catch (error)
    {
      if(kDebugMode)
      {
        print(error);
      }
      showDialog(context: context, builder: (c)=> const AlertDialog(content: Text("Cancelled"),));
    }
    catch(errorMsg)
    {
      if(kDebugMode)
      {
        print(errorMsg);
      }
      print(errorMsg.toString());
    }
  }

  void paymentSheetInitialization(double amountToBeCharged, String currency) async {
    try {
      int amountInCents = (amountToBeCharged * 100).round(); // هنا نضرب ب100 ونخليه int

      intentPaymentData = await makeIntentForPayment(amountInCents, currency);

      if (intentPaymentData != null && intentPaymentData!['client_secret'] != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            allowsDelayedPaymentMethods: true,
            paymentIntentClientSecret: intentPaymentData!['client_secret'],
            style: ThemeMode.light,
            merchantDisplayName: "merchantDisplayName",
          ),
        );

        showPaymentSheet();
      } else {
        print("intentPaymentData is null or missing 'client_secret'");
      }
    } catch (errorMsg, s) {
      if (kDebugMode) {
        print(s);
        print(errorMsg.toString());
      }
    }
  }

  // فتح الـ popup لعرض طرق الدفع
  void showAvailablePaymentMethods(BuildContext context) {
    final allMethods = PaymentMethodType.values.map((e) => e.name).toList();

    final existingMethods = context.read<PaymentsCubit>().state is PaymentsSuccess
        ? (context.read<PaymentsCubit>().state as PaymentsSuccess)
        .payments
        .map((p) => p?.methodType?.toLowerCase() ?? '')
        .toList()
        : [];

    final availableMethods = allMethods.where((m) => !existingMethods.contains(m)).toList();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose a payment method'),
          content: SingleChildScrollView(
            child: ListBody(
              children: availableMethods.map((method) {
                return ListTile(
                  leading: Icon(getIconForPlan(method)),
                  title: Text(method.toUpperCase()),
                  onTap: () {
                    Navigator.of(context).pop();
                    if (kDebugMode) {
                      print('Selected Payment Method: $method');
                    }
                    paymentSheetInitialization(amount, "usd");                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<PaymentsCubit>().getAllPayments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Payment Details",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<PaymentsCubit, PaymentsState>(
              builder: (context, state) {
                if (state is PaymentsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PaymentsSuccess) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: state.payments.length,
                    itemBuilder: (context, index) {
                      final payment = state.payments[index];
                      final planName = payment?.methodType;
                      final icon = getIconForPlan(planName);
                      final color = getColorForPlan(planName);
                      return material.Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: color,
                              width: 1.5,
                            ),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Icon(icon, size: 40, color: color),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      payment?.methodType?.toUpperCase() ?? '',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is PaymentsError) {
                  return Center(child: Text(state.message));
                }
                return Container();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {

                  showAvailablePaymentMethods(context);
                },
                icon: const Icon(Icons.add, color: Colors.black),
                label: const Text(
                  "Add payment methods",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              )

            ),
          ),
        ],
      ),
    );
  }
}
