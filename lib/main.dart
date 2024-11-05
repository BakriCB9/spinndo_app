import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/auth/view/log_in/sign_in_screen.dart';
import 'package:snipp/auth/view/screen/employee_details.dart';
import 'package:snipp/auth/view/screen/forget_password_screen.dart';

import 'package:snipp/auth/view/screen/upload_profile_image.dart';
import 'package:snipp/auth/view/screen/verfication_code_screen.dart';
import 'package:snipp/auth/view/sign_up/account_type_screen.dart';
import 'package:snipp/auth/view/sign_up/select_job_time.dart';
import 'package:snipp/auth/view/sign_up/sign_up_screen.dart';
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
        designSize: const Size(412, 870),
        builder: (context, _) {
          return MaterialApp(
            theme: ThemeData(
                fontFamily: "ElMessiri",
                appBarTheme: AppBarTheme(backgroundColor: Colors.blue)),
            // home: RegisterScreen(),
            initialRoute: SignUpScreen.routeName,
            routes: {
              EmployeeDetails.routeName: (context) => EmployeeDetails(),
              // SelectJobTime.routeName: (context) => SelectJobTime(),
              AccountTypeScreen.routeName: (context) => AccountTypeScreen(),
              ForgotPasswordScreen.routeName: (context) =>
                  ForgotPasswordScreen(),
              SignUpScreen.routeName: (context) => SignUpScreen(),
              SignInScreen.routeName: (context) => SignInScreen(),
              // Define registration page as in previous code
              UploadProfileImage.routeName: (context) => UploadProfileImage(),
              // Define registration page as in previous code
              VerficationCodeScreen.routeName: (context) =>
                  VerficationCodeScreen(),
              // Define registration page as in previous code
              TestWidget.routeName: (context) => TestWidget(),
              // Define registration page as in previous code
            },
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
