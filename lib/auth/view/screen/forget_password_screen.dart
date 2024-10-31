import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/auth/view/screen/reset_password_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  static const String routeName='/forget';

  void _navigateToResetPassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.lock_reset, size: 100.h, color: Colors.blue),
            SizedBox(height: 20.h),
            Text(
              'Enter your email to reset your password',
              style: TextStyle(fontSize: 18.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () => _navigateToResetPassword(context),
              child: Text('Submit', style: TextStyle(fontSize: 18.sp,color: Colors.blue)),
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
