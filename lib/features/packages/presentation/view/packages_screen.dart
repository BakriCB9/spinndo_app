import 'dart:convert';

import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/resources/theme_manager.dart';
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
import 'package:flutter_stripe/flutter_stripe.dart';
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

    // this must be moved to the first page
    // this function must only return true/false
    return result ?? false;
    // if (result == true) {
    //   final localization = AppLocalizations.of(context)!;
    //   final cubit = context.read<PackagesCubit>();
    //   final int userId = cubit.getUserId();
    //
    //   try {
    //     final List<dynamic>? paymentTypes =
    //         paymentIntentData?['payment_method_types'];
    //     final String? methodType =
    //         (paymentTypes != null && paymentTypes.isNotEmpty)
    //             ? paymentTypes[0]
    //             : null;
    //     final String? intentId = paymentIntentData?['id']?.toString();
    //
    //     if (methodType != null && intentId != null) {
    //       print('نوع الدفع: $methodType - Stripe ID: $intentId');
    //
    //       final method = PaymentMethodModel(
    //         userId: userId,
    //         methodType: methodType,
    //         stripePaymentMethodId: intentId,
    //       );
    //
    //       await context.read<PaymentsCubit>().addPayment(method);
    //
    //       if (context.read<PaymentsCubit>().state is PaymentAddSuccess) {
    //         await Stripe.instance.confirmPaymentSheetPayment();
    //         if (context.read<PaymentsCubit>().state is PaymentAddSuccess) {
    //           final subscription = SubscribeModel(
    //             userId: userId,
    //             packageId: package.id!,
    //           );
    //           await cubit.addSubscription(subscription);
    //           await cubit.getAllPackages();
    //
    //           ScaffoldMessenger.of(context).showSnackBar(
    //             SnackBar(content: Text('${localization.paymentSuccessful} 🎉')),
    //           );
    //         } else if (context.read<PaymentsCubit>().state is PaymentAddError) {
    //           final errorState =
    //               context.read<PaymentsCubit>().state as PaymentAddError;
    //           print("فشل إضافة وسيلة الدفع: ${errorState.message}");
    //         }
    //       }
    //     } else {
    //       print("خطأ: البيانات غير كاملة من Stripe");
    //     }
    //   } on StripeException catch (e) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //           content: Text(
    //               '${localization.errorStripe}: ${e.error.localizedMessage}')),
    //     );
    //   } catch (e) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //           content: Text('${localization.anUnexpectedErrorOccurred} $e')),
    //     );
    //   }
    //   cubit.getAllPackages();
    // } else if (result == false && paymentIntentData != null) {
    //   String? id = paymentIntentData!['id']?.toString();
    //   if (id != null && id.isNotEmpty) {
    //     await context.read<PaymentsCubit>().addRefund(id);
    //   }
    // }
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

    return Container(
      decoration: _drawerCubit.themeMode == ThemeMode.dark
          ? const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/images/bg.png"), fit: BoxFit.fill))
          : null,
      child: Scaffold(
        appBar: AppBar(
          title: Text(localization.packages),
          backgroundColor: Colors.yellow[700],
        ),
        body: BlocBuilder<PackagesCubit, PackagesState>(
          builder: (context, state) {
            if (state is PackagesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PackagesSuccess) {
              return ListView.builder(
                padding: EdgeInsets.all(12),
                itemCount: state.packages.length,
                itemBuilder: (context, index) {
                  final package = state.packages[index];
                  final isSubscribed = package?.is_subscribed ?? false;
                  return material.Card(
                    color: _drawerCubit.themeMode == ThemeMode.dark
                        ? Colors.indigo[950]
                        : Colors.yellow[50],
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                isSubscribed
                                    ? Icons.circle
                                    : Icons.circle_outlined,
                                size: 16,
                                color: ColorManager.primary,
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    package!.name!,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "${localization.price} ${package?.price}",
                                    style: TextStyle(
                                        fontSize: 16),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "${localization.duration} ${package?.duration}",
                                    style: TextStyle(
                                        fontSize: 16),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (package == null) return;

                                        final cubit =
                                            context.read<PackagesCubit>();
                                        final int userId = cubit.getUserId();

                                        if (isSubscribed) {
                                          // المستخدم مشترك بالفعل - عرض خيار الإلغاء
                                          final result = await showDialog<bool>(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text(localization
                                                  .cancelSubscription),
                                              content: Text(localization
                                                      .doYouWantToUnsubscribeFromThisPackage +
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
                                                  child: Text(localization.yes),
                                                ),
                                              ],
                                            ),
                                          );

                                          if (result == true) {
                                            await cubit
                                                .cancelSubscription(userId);
                                            cubit
                                                .getAllPackages(); // تحديث القائمة بعد الإلغاء
                                          }
                                        } else {
                                          // تحقق إن كان لديه اشتراك نشط في أي باقة أخرى
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
                                            return; // خروج إذا لديه اشتراك
                                          }

                                          // عرض تأكيد الاشتراك
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
                                                  child: Text(localization.yes),
                                                ),
                                              ],
                                            ),
                                          );

                                          if (confirmResult != true) return;

                                          // عملية الدفع
                                          var isPaid =
                                              await showAvailablePaymentMethods(
                                                  context,
                                                  package.price ?? 0.0);

                                          if (isPaid != true) {
                                            print("لم تتم عملية الدفع");
                                            return;
                                          }

                                          // تنفيذ الاشتراك بعد الدفع
                                          final subscription = SubscribeModel(
                                            userId: userId,
                                            packageId: package.id,
                                          );

                                          await cubit
                                              .addSubscription(subscription);
                                          cubit
                                              .getAllPackages(); // تحديث القائمة بعد الاشتراك
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
                                          isSubscribed
                                              ? '${localization.subscribed} ✅'
                                              : '${localization.subscribe}',
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is PackagesError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text("no pacs"));
            }
          },
        ),
      ),
    );
  }
}
