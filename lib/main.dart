import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/auth/view/screen/deploma_protofile_image_screen.dart';
import 'package:snipp/auth/view/screen/sign_in_screen.dart';
import 'package:snipp/auth/view/screen/employee_details.dart';
import 'package:snipp/auth/view/screen/forget_password_screen.dart';

import 'package:snipp/auth/view/screen/verfication_code_screen.dart';
import 'package:snipp/auth/view/screen/account_type_screen.dart';
import 'package:snipp/auth/view/screen/sign_up_screen.dart';
import 'package:snipp/profile/view/screen/profile_screen.dart';

void main() {
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
    return ScreenUtilInit(
        designSize: const Size(720, 1640),
        builder: (context, _) {
          return MaterialApp(
            theme: ThemeData(
                fontFamily: "ElMessiri",
                appBarTheme: const AppBarTheme(backgroundColor: Colors.blue)),
            // home: RegisterScreen(),
            initialRoute: SignUpScreen.routeName,
            routes: {
              EmployeeDetails.routeName: (context) => const EmployeeDetails(),
              DeplomaProtofileImageScreen.routeName: (context) =>
                  DeplomaProtofileImageScreen(),
              AccountTypeScreen.routeName: (context) => AccountTypeScreen(),
              ForgotPasswordScreen.routeName: (context) =>
                  ForgotPasswordScreen(),
              SignUpScreen.routeName: (context) => SignUpScreen(),
              SignInScreen.routeName: (context) => SignInScreen(),
              VerficationCodeScreen.routeName: (context) =>
                  VerficationCodeScreen(),
              TestWidget.routeName: (context) => const TestWidget(),
            },
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
