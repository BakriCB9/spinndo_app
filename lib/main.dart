import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            home: TestWidget(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
