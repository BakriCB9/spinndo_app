import 'package:app/features/payment/presentation/view/payment_screen.dart';
import 'package:app/features/profile/data/data_source/local/profile_local_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/packages_cubit.dart';
import '../view_model/packages_state.dart';

class PackagesScreen extends StatefulWidget {
  static const String routeName = '/packages';

  const PackagesScreen({Key? key}) : super(key: key);

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PackagesCubit>().getAllPackages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Packages"),
        backgroundColor: Colors.yellow[700],
      ),
      body: BlocBuilder<PackagesCubit, PackagesState>(
        builder: (context, state) {
          if (state is PackagesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PackagesSuccess) {
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: state.packages.length,
              itemBuilder: (context, index) {
                final package = state.packages[index];
                final isSubscribed = package?.is_subscribed ?? false;

                return InkWell(
                  onTap: () {},
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow[50],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.black45,
                          width: 1.5,
                        ),
                      ),
                      padding: const EdgeInsets.all(26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                isSubscribed ? Icons.check_circle : Icons
                                    .cancel,
                                size: 40,
                                color: isSubscribed ? Colors.green : Colors.red,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      package?.name ?? '',
                                      style: const TextStyle(fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Price: ${package?.price ?? 0}€",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Duration: ${package?.duration ??
                                          3} month",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (package == null) return;

                                if (isSubscribed) {
                                  final result = await showDialog<bool>(
                                    context: context,
                                    builder: (context) =>
                                        AlertDialog(
                                          title: const Text(
                                              'Cancel Subscription'),
                                          content: const Text(
                                              'Do you want to unsubscribe from this package?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(
                                                      false),
                                              child: const Text('No'),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(
                                                      true),
                                              child: const Text('Yes'),
                                            ),
                                          ],
                                        ),
                                  );

                                  if (result == true) {
                                    final cubit = context.read<PackagesCubit>();
                                    final int userId = cubit.getUserId();
                                    await cubit.cancelSubscription(userId);
                                    cubit
                                        .getAllPackages();
                                  }
                                } else {
                                  final result = await showDialog<bool>(
                                    context: context,
                                    builder: (context) =>
                                        AlertDialog(
                                          title: const Text(
                                              'Confirm Subscription'),
                                          content: const Text(
                                              'Do you want to subscribe to this package?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(
                                                      false),
                                              child: const Text('No'),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(
                                                      true),
                                              child: const Text('Yes'),
                                            ),
                                          ],
                                        ),
                                  );

                                  if (result == true) {
                                    final cubit = context.read<PackagesCubit>();
                                    final int userId = cubit.getUserId();
                                    final subscribeModel = cubit
                                        .createSubscribeModel(package, userId);
                                    await cubit.addSubscription(subscribeModel);
                                    cubit.getAllPackages();
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (conetxt) {
                                          return PaymentsScreen();
                                        })
                                    );
                              }
                              }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isSubscribed
                                    ? Colors.grey
                                    : Colors.yellow[700],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  isSubscribed ? 'Subscribed ✅' : 'Subscribe',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is PackagesError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
