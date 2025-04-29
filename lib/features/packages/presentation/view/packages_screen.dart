import 'package:app/features/payment/presentation/view/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/packages_cubit.dart';
import '../view_model/packages_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.packages),
        backgroundColor: Colors.yellow[700],
      ),
      body: BlocBuilder<PackagesCubit, PackagesState>(
        builder: (context, state) {
          if (state is PackagesLoading) {
            return  Center(child: CircularProgressIndicator());
          } else if (state is PackagesSuccess) {
            return ListView.builder(
              padding:  EdgeInsets.all(12),
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
                    margin:  EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow[50],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.black45,
                          width: 1.5,
                        ),
                      ),
                      padding:  EdgeInsets.all(26),
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
                                      "${localization.price} ${package?.price ?? 0}€",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "${localization.duration} ${package?.duration ?? 0}month",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
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
                                          title:  Text("${localization.cancelSubscription}"),
                                          content:  Text("${localization.doYouWantToUnsubscribeFromThisPackage}?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(
                                                      false),
                                              child:  Text(localization.no),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(
                                                      true),
                                              child:  Text(localization.yes),
                                            ),
                                          ],
                                        ),
                                  );

                                  if (result == true) {
                                    final cubit = context.read<PackagesCubit>();
                                    final int userId = cubit.getUserId();
                                    await cubit.cancelSubscription(userId);
                                    cubit.getAllPackages();
                                  }
                                } else {
                                  bool hasActiveSubscription = state.packages.any((package) => package?.is_subscribed == true);
                                  if (hasActiveSubscription) {
                                    // عنده اشتراك آخر → نظهر رسالة منع
                                    await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title:  Text(localization.subscriptionError),
                                        content:  Text("${localization.youCannotSubscribeToMoreThanOnePackageAtATime}."),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(),
                                            child: Text(localization.ok),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  else{
                                    final result = await showDialog<bool>(
                                      context: context,
                                      builder: (context) =>
                                          AlertDialog(
                                            title:  Text(
                                                localization.confirmSubscription),
                                            content:  Text("${localization.doYouWantToSubscribeToThisPackage}?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(
                                                        false),
                                                child:  Text(localization.no),
                                              ),
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(
                                                        true),
                                                child:  Text(localization.yes),
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
                                  isSubscribed ? '${localization.subscribed} ✅' : '${localization.subscribe}',
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