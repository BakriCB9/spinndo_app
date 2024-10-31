import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/auth/view/screen/login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();

  void _resetPassword() {
    // Add logic to reset the password, like calling an API
    Navigator.of(context).pushNamed(LoginScreen.routeName);

    print("Password reset successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password',),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.lock, size: 100.h, color: Colors.blue),
            SizedBox(height: 20.h),
            Text(
              'Enter a new password',
              style: TextStyle(fontSize: 18.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.h),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: _resetPassword,
              child: Text('Reset Password', style: TextStyle(fontSize: 18.sp,color: Colors.blue)),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
