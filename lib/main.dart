import 'package:app/core/routes/routes.dart';
import 'package:app/core/routes/routes_generator.dart';
import 'package:app/core/utils/fcm.dart';
import 'package:app/default_firebase_options.dart';
import 'package:app/features/discount/presentation/view/add_discount_screen.dart';
import 'package:app/features/drawer/presentation/screens/setting_screen.dart';
import 'package:app/features/favorite/presentation/view/favorite_screen.dart';
import 'package:app/features/packages/presentation/view_model/packages_cubit.dart';
import 'package:app/features/payment/presentation/view/payment_screen.dart';
import 'package:app/features/payment/presentation/view_model/payments_cubit.dart';
import 'package:app/features/service/presentation/screens/notification_screen.dart';
import 'package:app/features/service_requist/presentation/view/add_service_request_screen.dart';
import 'package:app/features/service_requist/presentation/view/get_service_request_screen.dart';
import 'package:app/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/core/app_bloc_observer.dart';

import 'package:app/core/di/service_locator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:app/core/resources/theme_manager.dart';
import 'package:app/features/auth/presentation/screens/deploma_protofile_image_screen.dart';
import 'package:app/features/auth/presentation/screens/employee_details.dart';
import 'package:app/features/auth/presentation/screens/map_screen.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_states.dart';
import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app/features/profile/presentation/screens/profile_screen.dart';
import 'package:app/features/service/presentation/screens/service_map_screen.dart';
import 'package:app/features/service/presentation/screens/service_screen.dart';

import 'core/constant.dart';
import 'features/packages/presentation/view/packages_screen.dart';
import 'features/payment/keys.dart';

late final SharedPreferences sharedPref;
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final navObserver = NavigationStackObserver();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = PublishableKey;
  await Stripe.instance.applySettings();

  await configureDependencies();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    // options: DefaultFirebaseOptions.web,
    // options:  FirebaseOptions(apiKey: apiKey, appId: appId, messagingSenderId: messagingSenderId, projectId: projectId)
  );
  Fcm.init();
  sharedPref = await SharedPreferences.getInstance();
  await ScreenUtil.ensureScreenSize();
  final _drawerCubit = serviceLocator.get<DrawerCubit>();
  await _drawerCubit.loadLanguage();
  await _drawerCubit.loadThemeData();

  Bloc.observer = AppBlocObserver();
  runApp(DevicePreview(
      enabled: false,
      builder: (_) {
        return MyApp();
      }));
}

class MyApp extends StatelessWidget {
  final userToken = sharedPref.getString(CacheConstant.tokenKey);

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => serviceLocator.get<ProfileCubit>(),
          ),
          BlocProvider(
            create: (context) => serviceLocator.get<DrawerCubit>(),
          ),
          BlocProvider(
            create: (context) => serviceLocator.get<PackagesCubit>(),
          ),
          BlocProvider(
            create: (context) => serviceLocator.get<PaymentsCubit>(),
          )
        ],
        child: ScreenUtilInit(
            splitScreenMode: true,
            designSize: const Size(720, 1640),
            builder: (context, _) {
              return Builder(builder: (context) {
                return BlocBuilder<DrawerCubit, DrawerStates>(
                  builder: (context, state) {
                    return MaterialApp(
                      navigatorObservers: [navObserver],
                      navigatorKey: navigatorKey,
                      theme: ThemeManager.lightTheme,
                      darkTheme: ThemeManager.darkTheme,
                      themeMode:
                          BlocProvider.of<DrawerCubit>(context).themeMode,
                      localizationsDelegates:
                          AppLocalizations.localizationsDelegates,
                      supportedLocales: AppLocalizations.supportedLocales,
                      locale: Locale(
                          BlocProvider.of<DrawerCubit>(context).languageCode),
                      onGenerateRoute: RoutesGenerator.getRoute,
                      //home: HomeScreen(),
                     // initialRoute: Routes.verificationRoutes,
                       initialRoute: SplashScreen.routeName,
                      // sharedPref.getString(CacheConstant.tokenKey) == null
                      //     ? (sharedPref.getString(CacheConstant.emailKey) ==
                      //             null
                      //         ? SignUpScreen.routeName
                      //         : SignInScreen.routeName)
                      //     : ServiceScreen.routeName,
                      routes: {
                        DiscountScreen.routeName: (context) => DiscountScreen(),
                        AddServiceRequestScreen.routeName: (context) =>
                            const AddServiceRequestScreen(),
                        GetServiceRequestScreen.routeName: (context) =>
                            const GetServiceRequestScreen(),
                        FavoriteScreen.routeName: (context) =>
                            const FavoriteScreen(),
                        EmployeeDetails.routeName: (context) =>
                            EmployeeDetails(),
                        SettingScreen.routeName: (context) =>
                            const SettingScreen(),
                        NotificationScreen.routeName: (context) =>
                            const NotificationScreen(),
                        ServiceScreen.routeName: (context) => ServiceScreen(),
                        SplashScreen.routeName: (context) => SplashScreen(),
                        ServiceMapScreen.routeName: (context) =>
                            ServiceMapScreen(),
                        // FilterResultScreen.routeName: (context) => FilterResultScreen(),
                        DeplomaProtofileImageScreen.routeName: (context) =>
                            DeplomaProtofileImageScreen(),
                        // ForgotPasswordScreen.routeName: (context) =>
                        //     ForgotPasswordScreen(),
                        // SignUpScreen.routeName: (context) => SignUpScreen(),
                        MapScreen.routeName: (context) => MapScreen(),
                        // SignInScreen.routeName: (context) => SignInScreen(),
                        // VerficationCodeScreen.routeName: (context) =>
                        //     VerficationCodeScreen(),
                        Profile_Screen.routeName: (context) =>
                            const Profile_Screen(),
                        PackagesScreen.routeName: (context) =>
                            const PackagesScreen(),
                        PaymentsScreen.routeName: (context) => PaymentsScreen(),
                      },
                      debugShowCheckedModeBanner: false,
                    );
                  },
                );
              });
            }));
  }
}

class NavigationStackObserver extends NavigatorObserver {
  final List<Route<dynamic>> _stack = [];

  int get stackSize => _stack.length;

  printRouts() {
    for (int i = 0; i < _stack.length; i++) {
      print('******');
      print(_stack[i].settings.name);
      print('******');
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _stack.add(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _stack.remove(route);
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _stack.remove(route);
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    final index = _stack.indexOf(oldRoute!);
    if (index != -1) {
      _stack[index] = newRoute!;
    }
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
