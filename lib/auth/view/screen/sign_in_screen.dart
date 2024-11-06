import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/auth/view/sign_up/sign_up_screen.dart';
import 'package:snipp/auth/view/widgets/custom_text_form_field.dart';
import 'package:snipp/profile/view/screen/profile_screen.dart';

import 'screen/forget_password_screen.dart';
import 'screen/verfication_code_screen.dart';
import 'widgets/default_text_form_field.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  static const String routeName = '/signin';
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isLogIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFF0F8FF),
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  TestWidget.routeName,
                );
              },
              child: Text(
                "sign in as guest",
                style: TextStyle(color: Colors.blue.shade400),
              ))
        ],
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 36.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Icon(Icons.account_circle, size: 100.h, color: Colors.blue),
                SizedBox(height: 10),
                Text(
                  'Spinndo',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Spacer(),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: emailController,
                      icon: Icons.email,
                      labelText: 'Email',
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "please enter an email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomTextFormField(
                      controller: passwordController,
                      icon: Icons.lock,
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
                  ],
                )),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(ForgotPasswordScreen.routeName);
                    },
                    child: Text(
                      'Forget password?',
                      style: TextStyle(
                        color: Colors.blue,
                        fontFamily: "WorkSans",
                        fontWeight: FontWeight.w300,
                        fontSize: 16.sp,
                      ),
                    )),
              ),
            ),
            Spacer(flex: 3,),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() == true) {
                    Navigator.of(context).pushNamed(
                        VerficationCodeScreen.routeName,
                        arguments: isLogIn);
                  }
                },
                child: Text(
                  "Log in",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r))),
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 12.h))),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {

                },
                child: Text(
                  "Create new account",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue, width: 1),
                        borderRadius: BorderRadius.circular(30.r))),
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 16.h))),
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
