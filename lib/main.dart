import 'dart:io';

import 'package:app/core/utils/fcm.dart';
import 'package:app/default_firebase_options.dart';
import 'package:app/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/core/app_bloc_observer.dart';
import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:app/core/resources/theme_manager.dart';
import 'package:app/features/auth/presentation/screens/deploma_protofile_image_screen.dart';
import 'package:app/features/auth/presentation/screens/employee_details.dart';
import 'package:app/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:app/features/auth/presentation/screens/map_screen.dart';
import 'package:app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:app/features/auth/presentation/screens/verfication_code_screen.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_states.dart';
import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app/features/profile/presentation/screens/profile_screen.dart';
import 'package:app/features/service/presentation/screens/service_map_screen.dart';
import 'package:app/features/service/presentation/screens/service_screen.dart';

late final SharedPreferences sharedPref;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    // options: DefaultFirebaseOptions.web,
    // options:  FirebaseOptions(apiKey: apiKey, appId: appId, messagingSenderId: messagingSenderId, projectId: projectId)
  );
  Fcm.init();
  sharedPref = await SharedPreferences.getInstance();
  await ScreenUtil.ensureScreenSize();

  Bloc.observer = AppBlocObserver();
  runApp(DevicePreview(
      enabled: false,
      builder: (_) {
        return const MyApp();
      }));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => serviceLocator.get<ProfileCubit>(),
          ),

          BlocProvider(
            create: (context) => serviceLocator.get<DrawerCubit>(),
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
                      theme: ThemeManager.lightTheme,
                      darkTheme: ThemeManager.darkTheme,
                      themeMode:
                          BlocProvider.of<DrawerCubit>(context).themeMode,
                      localizationsDelegates:
                          AppLocalizations.localizationsDelegates,
                      supportedLocales: AppLocalizations.supportedLocales,
                      locale: Locale(
                          BlocProvider.of<DrawerCubit>(context).languageCode),
                      //home: HomeScreen(),
                      initialRoute:
                      // SplashScren.routeName,
                          sharedPref.getString(CacheConstant.tokenKey) == null
                              ? (sharedPref.getString(CacheConstant.emailKey) ==
                                      null
                                  ? SignUpScreen.routeName
                                  : SignInScreen.routeName)
                              : ServiceScreen.routeName,
                      routes: {
                        EmployeeDetails.routeName: (context) =>
                            EmployeeDetails(),

                        ServiceScreen.routeName: (context) => ServiceScreen(),
                        // SplashScren.routeName: (context) =>SplashScren(),
                        ServiceMapScreen.routeName: (context) =>
                            ServiceMapScreen(),
                        // FilterResultScreen.routeName: (context) => FilterResultScreen(),
                        DeplomaProtofileImageScreen.routeName: (context) =>
                            const DeplomaProtofileImageScreen(),
                        ForgotPasswordScreen.routeName: (context) =>
                            ForgotPasswordScreen(),
                        SignUpScreen.routeName: (context) => SignUpScreen(),
                        MapScreen.routeName: (context) => MapScreen(),
                        SignInScreen.routeName: (context) => SignInScreen(),
                        VerficationCodeScreen.routeName: (context) =>
                            VerficationCodeScreen(),
                        Profile_Screen.routeName: (context) =>
                            const Profile_Screen(),
                      },
                      debugShowCheckedModeBanner: false,
                    );
                  },
                );
              });
            }));
  }
}
