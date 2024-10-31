import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/auth/view/screen/employee_details.dart';
import 'package:snipp/auth/view/screen/login_screen.dart';
import 'package:snipp/auth/view/screen/verfication_code_screen.dart';
import 'package:snipp/auth/view/widgets/default_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  static const String routeName='/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();

  final firstNameContoller = TextEditingController();

  final lastNameContoller = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isClient = true;

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
                  DefaultTextFormField(
                    controller: firstNameContoller,
                    icon: Icons.person,
                    labelText: 'First Name',
                  ),
                  SizedBox(height: 20.h),
                  DefaultTextFormField(
                    controller: lastNameContoller,
                    icon: Icons.person_outline,
                    labelText: 'Last Name',
                  ),
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
                  DefaultTextFormField(
                    controller: confirmPasswordController,
                    icon: Icons.lock,
                    labelText: 'Confirm Password',
                  ),
                  SizedBox(height: 20.h),
                ],
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Radio<bool>(
                      value: true,
                      activeColor: Colors.blue,
                      hoverColor: Colors.blue,
                      groupValue: isClient,
                      onChanged: (value) {
                        setState(() {
                          isClient = value!;
                        });
                      },
                    ),
                    Text(
                      'Client',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                SizedBox(width: 16),
                Row(
                  children: [
                    Radio<bool>(
                      activeColor: Colors.blue,
                      hoverColor: Colors.blue,
                      value: false,
                      groupValue: isClient,
                      onChanged: (value) {
                        setState(() {
                          isClient = value!;
                        });
                      },
                    ),
                    Text('Employee', style: TextStyle(fontSize: 20))
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          isClient?Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(VerficationCodeScreen.routeName,     arguments: isClient);


              },
              child: Text(
                "Sign Up",
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blue),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r))),
                  padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 10.h))),
            ),
          ):Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(VerficationCodeScreen.routeName,
                    arguments: isClient
                );
              },
              child: Text(
                "Next >>",
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
                Navigator.of(context).pushNamed(LoginScreen.routeName);


              },
              child: Text(
                'already have account?',
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
