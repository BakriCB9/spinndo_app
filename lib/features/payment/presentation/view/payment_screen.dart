import 'dart:convert';
import 'package:app/features/packages/presentation/view_model/packages_cubit.dart';
import 'package:app/features/payment/data/model/payments_model.dart';
import 'package:app/features/payment/keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import '../view_model/payments_cubit.dart';
import '../view_model/payments_state.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



enum PaymentMethodType {
  klarna,
  paypal,
  mastercard,
  visa,
  maestro,
}

// Get icon for each payment method
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

// Get color for each payment method
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
  String? selectedPaymentMethodId;
  Map<String, dynamic>? intentPaymentData;
  http.Response? responseFromStripeAPI;
  Map<String, dynamic>? paymentIntentData;

  Future<Map<String, dynamic>?> makeIntentForPayment(int amountToBeCharged, String currency, String paymentMethodType) async {
    try {
      Map<String, dynamic> paymentInfo = {
        "amount": amountToBeCharged.toString(),
        "currency": currency,
        "payment_method_types[]": paymentMethodType,
      };
      responseFromStripeAPI = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: paymentInfo,
        headers: {
          "Authorization": "Bearer $SecretKey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );
      paymentIntentData = jsonDecode(responseFromStripeAPI!.body);
      print("pppi${paymentIntentData}");
      return paymentIntentData;
    } catch (errorMsg) {
      if (kDebugMode) {
        print(errorMsg);
      }
      return null;
    }
  }

  void showAvailablePaymentMethods(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final allMethods = PaymentMethodType.values.map((e) => e.name).toList();

    final existingMethods = context.read<PaymentsCubit>().state is PaymentsSuccess
        ? (context.read<PaymentsCubit>().state as PaymentsSuccess).payments.map((p) => p?.methodType ?? '').toList()
        : [];

    final availableMethods = allMethods.where((m) => !existingMethods.contains(m)).toList();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(localization.chooseAPaymentMethod),
          content: SingleChildScrollView(
            child: ListBody(
              children: availableMethods.map((method) {
                return ListTile(
                  leading: Icon(getIconForPlan(method)),
                  title: Text(method.toUpperCase()),
                  onTap: () {
                    Navigator.of(context).pop();
                    String paymentType = ['klarna', 'paypal'].contains(method.toLowerCase()) ? method.toLowerCase() : 'card';
                    paymentSheetInitialization(amount, "eur", paymentType);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void paymentSheetInitialization(double amountToBeCharged, String currency, String paymentMethodType) async {
    try {
      int amountInCents = (amountToBeCharged * 100).round();
      intentPaymentData = await makeIntentForPayment(amountInCents, currency, paymentMethodType);

      if (intentPaymentData != null && intentPaymentData!['client_secret'] != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            customFlow: true,
            customerId: intentPaymentData!['id'],
            allowsDelayedPaymentMethods: true,
            paymentIntentClientSecret: intentPaymentData!['client_secret'],
            customerEphemeralKeySecret: intentPaymentData!['ephermal_key'],
            style: ThemeMode.light,
            merchantDisplayName: "merchantDisplayName",
          ),
        );
        showPaymentSheet();
      }
    } catch (errorMsg, s) {
      if (kDebugMode) {
        print(s);
        print(errorMsg.toString());
      }
    }
  }

  Future<void> showPaymentSheet() async {
    final localization = AppLocalizations.of(context)!;
    try {
      await Stripe.instance.presentPaymentSheet().then((val) {
        showConfirmPaymentDialog();
        intentPaymentData = null;
      });
    } on StripeException catch (_) {
      showDialog(
        context: context,
        builder: (c) => AlertDialog(content: Text(localization.theOperationHasBeenCancelled)),
      );
    } catch (errorMsg) {
      if (kDebugMode) {
        print(errorMsg);
      }
    }
  }

  Future<void> showConfirmPaymentDialog() async {
    final localization = AppLocalizations.of(context)!;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(localization.paymentConfirmation),
          content: Text('${localization.areYouSureYouWantToProceedWithThePayment}?'),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(localization.no)),
            TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text(localization.yes)),
          ],
        );
      },
    );

    if (result == true) {
      await confirmPayment(); // أكّد الدفع فقط إذا نجحت الإضافة

      // final cubit = context.read<PackagesCubit>();
      // final int userId = cubit.getUserId();
      //
      // final List<dynamic>? paymentTypes = paymentIntentData?['payment_method_types'];
      // final String? methodType = (paymentTypes != null && paymentTypes.isNotEmpty)
      //     ? paymentTypes[0]
      //     : null;
      //
      //
      // final String? intentId = paymentIntentData?['id']?.toString();
      //
      // if (methodType != null && intentId != null) {
      //   print('نوع الدفع: $methodType - Stripe ID: $intentId');
      //
      //   final method = PaymentMethodModel(
      //     id:0,
      //     userId: userId,
      //     methodType: methodType,
      //     stripePaymentMethodId: intentId,
      //   );
      //
      //   //final result = await context.read<PaymentsCubit>().addPayment(method);
      //
      //   // نتحقق إذا تمت إضافة طريقة الدفع بنجاح
      //   if (context.read<PaymentsCubit>().state is PaymentAddSuccess) {
      //     await confirmPayment(); // أكّد الدفع فقط إذا نجحت الإضافة
      //     await context.read<PaymentsCubit>().getAllPayments();
      //   } else if (context.read<PaymentsCubit>().state is PaymentAddError) {
      //     final errorState = context.read<PaymentsCubit>().state as PaymentAddError;
      //     print("فشل إضافة وسيلة الدفع: ${errorState.message}");
      //   }
      // } else {
      //   print("خطأ: البيانات غير كاملة من Stripe");
      // }
    }

    else if (result == false && paymentIntentData != null) {
      String? id = paymentIntentData!['id']?.toString();
      if (id != null && id.isNotEmpty) {
        await context.read<PaymentsCubit>().addRefund(id);
      }
    }
  }

  void showPreviouslyUsedPaymentMethods(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    final state = context.read<PaymentsCubit>().state;
    if (state is! PaymentsSuccess) return;

    final usedMethods = state.payments
        .where((p) => p?.methodType != null)
        .map((p) => p!.methodType!)
        .toSet()
        .toList(); // إزالة التكرارات

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('ss'),
          content: SingleChildScrollView(
            child: ListBody(
              children: usedMethods.map((method) {
                return ListTile(
                  leading: Icon(getIconForPlan(method)),
                  title: Text(method.toUpperCase()),
                  onTap: () {
                    Navigator.of(context).pop();
                    String paymentType = ['klarna', 'paypal'].contains(method.toLowerCase()) ? method.toLowerCase() : 'card';
                    paymentSheetInitialization(amount, "eur", paymentType);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }


  Future<void> confirmPayment() async {
    final localization = AppLocalizations.of(context)!;
    try {
      await Stripe.instance.confirmPaymentSheetPayment();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${localization.paymentSuccessful}🎉')),
      );
    } on StripeException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${localization.errorStripe}:${e.error.localizedMessage}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${localization.anUnexpectedErrorOccurred}$e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // context.read<PaymentsCubit>().getAllPayments();
    // showPreviouslyUsedPaymentMethods();

  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.paymentDetails, style: const TextStyle(color: Colors.black)),
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: color, width: 1.5),
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
                                      planName?.toUpperCase() ?? '',
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
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
                onPressed: () => showAvailablePaymentMethods(context),
                icon: const Icon(Icons.add, color: Colors.black),
                label: Text(
                  localization.addPaymentMethods,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
