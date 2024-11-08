import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/widgets/custom_text_form_field.dart';

import 'sign_in_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  void _resetPassword() {
    // Add logic to reset the password, like calling an API
    if (formKey.currentState?.validate() == true) {
      Navigator.of(context).pushNamed(SignInScreen.routeName);
    }
    print("Password reset successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F8FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.lock, size: 200.h, color: Colors.blue),
            SizedBox(height: 20.h),
            Text(
              'Enter a new password',
              style: TextStyle(fontSize: 32.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: passwordController,
                      icon: Icons.lock,
                      isPassword: true,
                      labelText: 'Password',
                      validator: (p1) {
                        if (p1 == null || p1.isEmpty) {
                          return "Password cannott be empty";
                        } else if (p1.length < 6) {
                          return "should be at least 6 charcters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextFormField(
                      validator: (p1) {
                        if (p1 == null || p1.isEmpty) {
                          return "Password cannott be empty";
                        } else if (p1.length < 6) {
                          return "should be at least 6 charcters";
                        } else if (passwordController.text !=
                            confirmPasswordController.text) {
                          return "Diffrent Password";
                        }

                        return null;
                      },
                      controller: confirmPasswordController,
                      icon: Icons.lock,
                      isPassword: true,
                      labelText: 'Confirm Password',
                    ),
                  ],
                )),
            Spacer(),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 40.h),
              child: ElevatedButton(
                onPressed: _resetPassword,
                child: Text('Verify',
                    style: TextStyle(fontSize: 32.sp, color: Colors.blue)),
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue, width: 1),
                        borderRadius: BorderRadius.circular(30.r))),
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 16.h))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
