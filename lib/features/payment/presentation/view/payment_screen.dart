import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/payments_cubit.dart';
import '../view_model/payments_state.dart';

// دوال جلب الأيقونة واللون حسب طريقة الدفع
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
    default:
      return Icons.monetization_on;
  }
}

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

                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
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
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text("Ajouter une nouvelle méthode de paiement")),
                  // );
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
