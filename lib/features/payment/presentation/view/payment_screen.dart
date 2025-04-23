import 'package:app/core/utils/package_utils/plan_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/payments_cubit.dart';
import '../view_model/payments_state.dart';

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
        title: const Text("Payment Details"),
        backgroundColor: Colors.green[700],
      ),
      body: BlocBuilder<PaymentsCubit, PaymentsState>(
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
                                payment?.methodType ?? '',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              // Text(
                              //   "Amount: ${payment?.amount ?? 0}€",
                              //   style: const TextStyle(fontSize: 14),
                              // ),
                              // const SizedBox(height: 8),
                              // Text(
                              //   "Date: ${payment?.date ?? ''}",
                              //   style: const TextStyle(fontSize: 14),
                              // ),
                              // const SizedBox(height: 8),
                              // Text(
                              //   "Status: ${payment?.status ?? 'N/A'}",
                              //   style: const TextStyle(fontSize: 14),
                              // ),
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
    );
  }
}
