import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/widgets/custom_text_form_field.dart';
import 'package:snipp/features/auth/data/models/register_request.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_states.dart';
import 'package:snipp/features/profile/presentation/screens/profile_screen.dart';

import '../../../../core/utils/ui_utils.dart';
import 'sign_in_screen.dart';
import 'verfication_code_screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  static const String routeName = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();

  final firstNameContoller = TextEditingController();

  final lastNameContoller = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final _authCubit = AuthCubit();

  @override
  Widget build(BuildContext context) {
    double avatarRadius = MediaQuery.of(context).size.width * 0.3;
    return Scaffold(
      // resizeToAvoidBottomInset: false,

      backgroundColor: const Color(0xFFF0F8FF),
      appBar: AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  Profile_Screen.routeName,
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
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                  radius: avatarRadius * 0.7,
                  backgroundColor: Colors.blue.shade300,
                  child: Icon(
                    Icons.person,
                    size: avatarRadius,
                    color: Colors.white,
                  )),
              SizedBox(height: 10.h),
              Text('Spinndo',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              SizedBox(height: 20.h),
              // const Spacer(flex: 1,),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "Name cannott be empty";
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
                          return "Name cannott be empty";
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
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "please enter an email";
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
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              BlocListener<AuthCubit, AuthState>(
                bloc: _authCubit,
                listener: (_, state) {
                  if (state is RegisterLoading) {
                    UIUtils.showLoading(context);
                  } else if (state is RegisterSuccess) {
                    UIUtils.hideLoading(context);
                    // Navigator.of(context).pushNamed();
                  } else if (state is RegisterError) {
                    UIUtils.hideLoading(context);
                    UIUtils.showMessage(state.message);
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _register,
                    style: ButtonStyle(
                        backgroundColor:
                            const WidgetStatePropertyAll(Colors.blue),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r))),
                        padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 12.h))),
                    child: Text(
                      "Next",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // const Spacer(),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30.h),
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(SignInScreen.routeName);
                      },
                      child: Text(
                        'I already have an account',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 24.sp,
                            fontFamily: "WorkSans",
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _register() {
    Navigator.of(context)
        .pushNamed(VerficationCodeScreen.routeName,arguments: emailController);
    _authCubit.register(RegisterRequest(
        first_name: firstNameContoller.text,
        last_name: lastNameContoller.text,
        email: emailController.text,
        password: passwordController.text));
  }
}
