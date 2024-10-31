import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/auth/view/screen/employee_details.dart';
import 'package:snipp/auth/view/screen/forget_password_screen.dart';
import 'package:snipp/auth/view/screen/login_screen.dart';
import 'package:snipp/auth/view/screen/register_screen.dart';
import 'package:snipp/auth/view/screen/upload_profile_image.dart';
import 'package:snipp/auth/view/screen/verfication_code_screen.dart';
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
          return  MaterialApp(
            theme: ThemeData(appBarTheme: AppBarTheme(backgroundColor: Colors.blue)),
            home: RegisterScreen(),
            initialRoute: RegisterScreen.routeName,
            routes: {
              EmployeeDetails.routeName: (context) => EmployeeDetails(),
              LoginScreen.routeName: (context) => LoginScreen(),
              ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
              RegisterScreen.routeName: (context) => RegisterScreen(), // Define registration page as in previous code
              UploadProfileImage.routeName: (context) => UploadProfileImage(), // Define registration page as in previous code
              VerficationCodeScreen.routeName: (context) => VerficationCodeScreen(), // Define registration page as in previous code
              TestWidget.routeName: (context) => TestWidget(), // Define registration page as in previous code
            },
            debugShowCheckedModeBanner: false,
          );
        });
  }
}

