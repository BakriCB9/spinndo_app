import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/features/auth/presentation/screens/reset_password_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  static const String routeName = '/forget';

  void _navigateToResetPassword(BuildContext context) {
    if (formKey.currentState?.validate() == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
      );
    }
  }

  final formKey = GlobalKey<FormState>();

  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F8FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reset Password",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 48.sp,
                      fontFamily: "WorkSans"),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  "we will send an email to you with code to reset password",
                  style:
                      TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w300),
                ),
              ],
            ),
            Icon(Icons.lock_reset, size: 200.sp, color: Colors.blue),
            SizedBox(height: 20.h),
            Text(
              'Enter your email to reset your password',
              style: TextStyle(
                fontSize: 32.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            Form(
              key: formKey,
              child: TextFormField(
                validator: (p1) {
                  if (p1 == null || p1.isEmpty) {
                    return "Password cannott be empty";
                  } else if (p1.length < 6) {
                    return "should be at least 6 charcters";
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.grey.shade800),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade300),
                      borderRadius: BorderRadius.all(Radius.circular(30.r))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade300),
                      borderRadius: BorderRadius.all(Radius.circular(30.r))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade300),
                      borderRadius: BorderRadius.all(Radius.circular(30.r))),
                  fillColor: Colors.white,
                  filled: true,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 40.h),
              child: ElevatedButton(
                onPressed: () => _navigateToResetPassword(context),
                style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(Colors.white),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.blue, width: 1),
                        borderRadius: BorderRadius.circular(30.r))),
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 16.h))),
                child: Text('Verify',
                    style: TextStyle(fontSize: 32.sp, color: Colors.blue)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
