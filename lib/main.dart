import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/app_bloc_observer.dart';
import 'package:snipp/core/di/service_locator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snipp/core/resources/theme_manager.dart';

import 'package:snipp/features/auth/presentation/screens/deploma_protofile_image_screen.dart';
import 'package:snipp/features/auth/presentation/screens/employee_details.dart';
import 'package:snipp/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:snipp/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:snipp/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:snipp/features/auth/presentation/screens/verfication_code_screen.dart';
import 'package:snipp/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:snipp/features/drawer/presentation/cubit/drawer_states.dart';
import 'package:snipp/features/home/presentation/screens/home_screen.dart';
import 'package:snipp/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:snipp/features/profile/presentation/screens/profile_screen.dart';
import 'package:snipp/features/service/presentation/screens/cat_select.dart';
import 'package:snipp/features/service/presentation/screens/service_screen.dart';
import 'package:snipp/geo.dart';
import 'package:snipp/mapss.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  Bloc.observer = AppBlocObserver();
  runApp(DevicePreview(
      enabled: true,
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
                      initialRoute: SignUpScreen.routeName,
                      routes: {
                        EmployeeDetails.routeName: (context) =>
                        const EmployeeDetails(),        MapWithDioBounds.routeName: (context) =>
                         MapWithDioBounds(),
                        ServiceScreen.routeName: (context) => ServiceScreen(),
                        FilterScreen.routeName: (context) => FilterScreen(),
                        DeplomaProtofileImageScreen.routeName: (context) =>
                            const DeplomaProtofileImageScreen(),
                        ForgotPasswordScreen.routeName: (context) =>
                            ForgotPasswordScreen(),
                        SignUpScreen.routeName: (context) => SignUpScreen(),
                        Mapss.routeName: (context) => Mapss(),
                        SignInScreen.routeName: (context) => SignInScreen(),
                        VerficationCodeScreen.routeName: (context) =>
                            const VerficationCodeScreen(),
                        Profile_Screen.routeName: (context) =>
                            const Profile_Screen(),
                        HomeScreen.routeName: (context) => const HomeScreen(),
                      },
                      debugShowCheckedModeBanner: false,
                    );
                  },
                );
              });
            }));
  }
}
