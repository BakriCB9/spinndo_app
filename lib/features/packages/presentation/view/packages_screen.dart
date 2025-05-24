import 'dart:convert';

import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/resources/theme_manager.dart';
import 'package:app/core/widgets/custom_appbar.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/packages/data/model/subscription/subscribe_model.dart';
import 'package:app/features/payment/data/model/payments_model.dart';
import 'package:app/features/payment/keys.dart';
import 'package:app/features/payment/presentation/view/payment_screen.dart';
import 'package:app/features/payment/presentation/view_model/payments_cubit.dart';
import 'package:app/features/payment/presentation/view_model/payments_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:lottie/lottie.dart';
import '../view_model/packages_cubit.dart';
import '../view_model/packages_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart' as material;

enum PaymentMethodType {
  klarna,
  paypal,
  mastercard,
  visa,
  maestro,
}

class PackagesScreen extends StatefulWidget {
  static const String routeName = '/packages';

  const PackagesScreen({Key? key}) : super(key: key);

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  double amount = 20;
  Map<String, dynamic>? intentPaymentData;
  http.Response? responseFromStripeAPI;
  Map<String, dynamic>? paymentIntentData;
  final _drawerCubit = serviceLocator.get<DrawerCubit>();
  late Size size= MediaQuery.of(context).size;



  Future<Map<String, dynamic>?> makeIntentForPayment(
      int amountToBeCharged, String currency, String paymentMethodType) async {
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

  Future<bool> paymentSheetInitialization(double amountToBeCharged,
      String currency, String paymentMethodType) async {
    try {
      int amountInCents = (amountToBeCharged * 100).round();
      intentPaymentData = await makeIntentForPayment(
          amountInCents, currency, paymentMethodType);

      if (intentPaymentData != null &&
          intentPaymentData!['client_secret'] != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            customFlow: true,
            customerId: intentPaymentData!['id'],
            allowsDelayedPaymentMethods: true,
            paymentIntentClientSecret: intentPaymentData!['client_secret'],
            merchantDisplayName: "merchantDisplayName",
          ),
        );
        var result = await showPaymentSheet();
        return result;
      }
      return false;
    } catch (errorMsg, s) {
      if (kDebugMode) {
        print(s);
        print(errorMsg.toString());
      }
      return false;
    }
  }

  Future<bool> showConfirmPaymentDialog() async {
    final localization = AppLocalizations.of(context)!;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(localization.paymentConfirmation),
          content:
          Text('${localization.areYouSureYouWantToProceedWithThePayment}?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(localization.yes)),
            TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(localization.no)),
          ],
        );
      },
    );
    // this function must only return true/false
    return result ?? false;
  }

  Future<bool> showPaymentSheet() async {
    final localization = AppLocalizations.of(context)!;
    try {
      await Stripe.instance.presentPaymentSheet();
      intentPaymentData = null;

      var result = await showConfirmPaymentDialog();
      return result;
    } on StripeException catch (_) {
      showDialog(
        context: context,
        builder: (c) => AlertDialog(
            content: Text(localization.theOperationHasBeenCancelled)),
      );
      return false;
    } catch (errorMsg) {
      if (kDebugMode) {
        print(errorMsg);
      }
      return false;
    }
  }

  Future<bool> showAvailablePaymentMethods(
      BuildContext context, double price) async {
    final localization = AppLocalizations.of(context)!;
    final allMethods = PaymentMethodType.values.map((e) => e.name).toList();

    final existingMethods =
    context.read<PaymentsCubit>().state is PaymentsSuccess
        ? (context.read<PaymentsCubit>().state as PaymentsSuccess)
        .payments
        .map((p) => p?.methodType ?? '')
        .toList()
        : [];

    final availableMethods =
    allMethods.where((m) => !existingMethods.contains(m)).toList();

    var result = await showDialog<bool>(
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
                  onTap: () async {
                    print("the priccce is${price}");
                    //Navigator.of(context).pop();

                    String paymentType = 'card';

                    if (method.toLowerCase() == 'klarna') {
                      paymentType = 'klarna';
                    } else if (method.toLowerCase() == 'paypal') {
                      paymentType = 'paypal';
                    } else {
                      paymentType = 'card';
                    }

                    String currency = (paymentType == 'klarna') ? 'usd' : 'eur';
                    var result = await paymentSheetInitialization(
                        price, currency, paymentType);
                    Navigator.of(context).pop(result);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
    return result!;
  }

  @override
  void initState() {
    super.initState();
    context.read<PackagesCubit>().getAllPackages();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final drawerCubit = serviceLocator.get<DrawerCubit>();
    final isDarkMode = drawerCubit.themeMode == ThemeMode.dark;
    final theme = Theme.of(context);

    return Container(
      decoration:
      isDarkMode ? const BoxDecoration(color: ColorManager.darkBg) : null,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30.h),
              CustomAppbar(appBarText: localization.packages),
              SizedBox(height:120.h),

              Expanded(
                child: BlocBuilder<PackagesCubit, PackagesState>(
                  builder: (context, state) {
                    if (state is PackagesLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is PackagesSuccess) {
                      return ListView.separated(
                        itemCount: state.packages.length,
                        itemBuilder: (context, index) {
                          final package = state.packages[index];
                          final isSubscribed = package?.is_subscribed ?? false;
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              material.Card(
                                color: _drawerCubit.themeMode == ThemeMode.dark
                                    ? Colors.indigo[950]
                                    : Colors.white,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                                child: Container(

                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [


                                      SizedBox(    width: 200.w,
                                        height: 200.h,),
                                      // Subscription Info
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            isSubscribed
                                                ? Icons.check_circle
                                                : Icons.circle_outlined,
                                            size: 20,
                                            color: ColorManager.primary,
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            isSubscribed
                                                ? localization
                                                .yourSubscriptionIsActive
                                                : localization
                                                .notSubscribedToThisPackage,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: _drawerCubit.themeMode ==
                                                  ThemeMode.dark
                                                  ? Colors.white
                                                  : Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 16),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,

                                        children: [
                                          Icon(
                                            Icons.access_time_filled_rounded,
                                            size: 20,
                                            color: ColorManager.primary,
                                          ),
                                          Text(
                                            " ${package?.duration} months",
                                            style: TextStyle(
                                              fontSize: 16,

                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 20),

                                      // Subscribe/Unsubscribe Button
                                      Align(
                                        alignment: Alignment.center,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (package == null) return;

                                            final cubit =
                                            context.read<PackagesCubit>();
                                            final int userId = cubit.getUserId();

                                            if (isSubscribed) {
                                              // The user is already subscribed – show the cancellation option
                                              final result = await showDialog<bool>(
                                                context: context,
                                                builder: (context) => AlertDialog(
                                                  title: Text(localization
                                                      .cancelSubscription),
                                                  content: Text(
                                                      "${localization.doYouWantToUnsubscribeFromThisPackage}?"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(false),
                                                      child: Text(localization.no),
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(true),
                                                      child: Text(localization.yes),
                                                    ),
                                                  ],
                                                ),
                                              );
                                              if (result == true) {
                                                await cubit
                                                    .cancelSubscription(userId);
                                                cubit
                                                    .getAllPackages(); // Refresh the list after cancellation
                                              }
                                            } else {
                                              // Check if the user has an active subscription to any other package

                                              bool hasActiveSubscription =
                                              state.packages.any(
                                                    (pkg) => pkg?.is_subscribed == true,
                                              );

                                              if (hasActiveSubscription) {
                                                await showDialog(
                                                  context: context,
                                                  builder: (context) => AlertDialog(
                                                    title: Text(localization
                                                        .subscriptionError),
                                                    content: Text(localization
                                                        .youCannotSubscribeToMoreThanOnePackageAtATime +
                                                        "."),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(context)
                                                                .pop(),
                                                        child:
                                                        Text(localization.ok),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                                return; // Logout if the user has a subscription
                                              }

                                              // Show subscription confirmation

                                              final confirmResult =
                                              await showDialog<bool>(
                                                context: context,
                                                builder: (context) => AlertDialog(
                                                  title: Text(localization
                                                      .confirmSubscription),
                                                  content: Text(localization
                                                      .doYouWantToSubscribeToThisPackage +
                                                      "?"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(false),
                                                      child: Text(localization.no),
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(true),
                                                      child: Text(localization.yes,style: TextStyle(color: ColorManager.primary),),
                                                    ),
                                                  ],
                                                ),
                                              );

                                              if (confirmResult != true) return;

                                              //paymentProcess
                                              var isPaid =
                                              await showAvailablePaymentMethods(
                                                  context,
                                                  package.price ?? 0.0);

                                              if (isPaid != true) {
                                                print("payment was not done");
                                                return;
                                              }

                                              //subscribe process after paying
                                              final subscription = SubscribeModel(
                                                userId: userId,
                                                packageId: package.id,
                                              );

                                              await cubit
                                                  .addSubscription(subscription);
                                              cubit
                                                  .getAllPackages(); //update UI after subscibe
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(30),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 12,
                                              horizontal: 24,
                                            ),
                                          ),
                                          child: Text(
                                            isSubscribed ? localization.subscribed : localization.subscribe,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -50,
                                left: 0,
                                right: 0,
                                child:  // Header Circle + Title
                                Center(
                                  child: Container(
                                    width: 300.w,
                                    height: 300.h,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Colors.orange,
                                          ColorManager.primary
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                          Colors.orange.withOpacity(0.4),
                                          blurRadius: 12,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          package!.name!.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "\$${package?.price.toStringAsFixed(0)}",
                                          style: TextStyle(fontSize: 27),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),)
                            ],
                          );


                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 150.h);
                        },
                      );
                    } else if (state is PackagesError) {
                      return Center(child: Text(state.message));
                    } else {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(height: 20.h,),
                            CustomAppbar(appBarText: localization.fav,),

                            const Spacer(),
                            SizedBox(
                              height: size.height / 3.5,
                              child: Lottie.asset(
                                'asset/animation/empty.json',
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'No items add yet!',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: 30.sp),
                            ),
                            const Spacer(
                              flex: 2,
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}