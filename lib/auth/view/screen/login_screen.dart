import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/auth/view/screen/forget_password_screen.dart';
import 'package:snipp/auth/view/screen/register_screen.dart';
import 'package:snipp/auth/view/screen/verfication_code_screen.dart';

import '../widgets/default_text_form_field.dart';

class  LoginScreen extends StatefulWidget {
  static const String routeName='/login';
  const  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();



  final passwordController = TextEditingController();


  final formKey = GlobalKey<FormState>();

  bool isLogIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 36.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Column(
            children: [
              Icon(Icons.account_circle, size: 100.h, color: Colors.blue),
              SizedBox(height: 8),
              Text(
                'spinndo',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 20.h),


                  SizedBox(height: 20.h),
                  DefaultTextFormField(
                    controller: emailController,
                    icon: Icons.email,
                    labelText: 'Email',
                  ),
                  SizedBox(height: 20.h),
                  DefaultTextFormField(
                    controller: passwordController,
                    icon: Icons.lock,
                    labelText: 'Password',
                  ),
                  SizedBox(height: 20.h),

                ],
              )), Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Align(alignment: Alignment.centerRight,
                  child: InkWell(
                  onTap: () {

                    Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName);

                  },
                  child: Text(
                    'Forget Password',
                    style: TextStyle(
                        color:Colors.blue,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400),
                  )),
                ),
              ),
          SizedBox(
            height: 10.h,
          ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(VerficationCodeScreen.routeName,arguments: isLogIn);

              },
              child: Text(
                "Log In",
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blue),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r))),
                  padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 10.h))),
            ),
          ),
          SizedBox(height: 20.h,),
          InkWell(
              onTap: () {

                Navigator.of(context).pushNamed(RegisterScreen.routeName);

              },
              child: Text(
                'Create new account',
                style: TextStyle(
                    color: Color(0xFF141922),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400),
              )),
          Text('or',  style: TextStyle(
              color: Color(0xFF141922),
              fontSize: 18.sp,
              fontWeight: FontWeight.w400),),
          InkWell(
              onTap: () {},
              child: Text(
                'sign as guest',
                style: TextStyle(
                    color: Color(0xFF141922),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400),
              )),
        ]),
      ),
    );
  }
}
