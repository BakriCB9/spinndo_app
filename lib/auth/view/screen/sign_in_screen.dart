import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/auth/view/screen/sign_up_screen.dart';
import 'package:snipp/auth/view/widgets/custom_text_form_field.dart';
import 'package:snipp/profile/view/screen/profile_screen.dart';

import 'forget_password_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  static const String routeName = '/signin';
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    double avatarRadius = MediaQuery.of(context).size.width * 0.3;
    return Scaffold(

      backgroundColor: const Color(0xFFF0F8FF),
      appBar: AppBar(elevation: 0,forceMaterialTransparency: true,
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
                CircleAvatar(
                    radius: avatarRadius * 0.7,
                    backgroundColor: Colors.blue.shade300,

                    child:  Icon(
                      Icons.person,
                      size: avatarRadius,
                      color: Colors.white,
                    )

                ),

                const SizedBox(height: 10),
                const Text(
                  'Spinndo',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
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
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
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
                        fontSize: 32.sp,
                      ),
                    )),
              ),
            ),
            const Spacer(flex: 3,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {

                    Navigator.of(context).pushNamed(
                        TestWidget.routeName,
                        );

                },
                style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(Colors.blue),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r))),
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 12.h))),
                child: Text(
                  "Log in",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                      SignUpScreen.routeName);
                },
                style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(Colors.white),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.blue, width: 1),
                        borderRadius: BorderRadius.circular(30.r))),
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 16.h))),
                child: Text(
                  "Create new account",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}