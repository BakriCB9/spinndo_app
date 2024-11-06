import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/auth/view/screen/sign_in_screen.dart';
import 'package:snipp/profile/view/screen/profile_screen.dart';

import '../screen/verfication_code_screen.dart';
import '../widgets/custom_text_form_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  static const String routeName = '/signup';
  final emailController = TextEditingController();

  final firstNameContoller = TextEditingController();

  final lastNameContoller = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isClient = true;
  bool isLogIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F8FF),
      appBar: AppBar(
        actions: [TextButton(onPressed: (){
          Navigator.of(context).pushNamed(TestWidget.routeName,);

        }, child: Text("sign in as guest",style: TextStyle(color: Colors.blue.shade400),))],
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Column(
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
            Spacer(flex: 1,),
            Form(key: formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return           "Name cannott be empty";

                      }
                      return null;
                    },
                    controller: firstNameContoller,
                    icon: Icons.person,
                    labelText: 'First name',
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextFormField(
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return           "Name cannott be empty";

                      }
                      return null;
                    },
                    controller: lastNameContoller,
                    icon: Icons.person,
                    labelText: 'Last name',
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextFormField(
                    validator:  (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return  "please enter an email";
                      }
                      return null;
                    },
                    controller: emailController,
                    icon: Icons.email,
                    labelText: 'Email',
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
                      }
                      return null;
                    },
                    controller: passwordController,
                    icon: Icons.lock,
                    isPassword: true,
                    labelText: 'Password',
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
                      }else if(passwordController.text!=confirmPasswordController.text){
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
              ),
            ),
            SizedBox(height: 26.h,),

            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(VerficationCodeScreen.routeName,arguments: isLogIn);

                },
                child: Text(
                  "Next",
                  style: TextStyle(color: Colors.white, fontSize: 18.sp,fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r))),
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 12.h))),
              ),
            ),
            Spacer(),
            Padding(
              padding:  EdgeInsets.only(bottom: 50.h),
              child: InkWell(
                  onTap: () {
      Navigator.of(context).pushNamed(SignInScreen.routeName);

                  },
                  child: Text(
                    'I already have an account',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18.sp,
fontFamily: "WorkSans",fontWeight: FontWeight.w600
                    ),
                  )),
            ),

          ],
        ),
      ),
    );
  }
}
