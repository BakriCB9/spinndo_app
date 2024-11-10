import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/core/utils/ui_utils.dart';
import 'package:snipp/core/widgets/custom_text_form_field.dart';
import 'package:snipp/features/auth/data/models/login_request.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_states.dart';
import 'package:snipp/features/profile/presentation/screens/profile_screen.dart';

import 'forget_password_screen.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  static const String routeName = '/signin';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final _authCubit = serviceLocator.get<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    double avatarRadius = MediaQuery.of(context).size.width * 0.3;
    return Scaffold(
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
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 36.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                CircleAvatar(
                    radius: avatarRadius * 0.7,
                    backgroundColor: Colors.blue.shade300,
                    child: Icon(
                      Icons.person,
                      size: avatarRadius,
                      color: Colors.white,
                    )),
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
            const Spacer(
              flex: 3,
            ),
            BlocListener(
              bloc: _authCubit,
              listener: (_, state) {
                if (state is LoginLoading) {
                  UIUtils.showLoading(context);
                } else if (state is LoginSuccess) {
                  UIUtils.hideLoading(context);
                  // Navigator.of(context).pushNamed();
                } else if (state is LoginError) {
                  UIUtils.hideLoading(context);
                  UIUtils.showMessage(state.message);
                }
              },
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login,
                  //     () {
                  //   Navigator.of(context).pushNamed(
                  //     TestWidget.routeName,
                  //   );
                  // },
                  style: ButtonStyle(
                      backgroundColor:
                          const WidgetStatePropertyAll(Colors.blue),
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
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(SignUpScreen.routeName);
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

  _login() {
// if(formKey.currentState?.validate()==true){
//     Navigator.of(context).pushNamed(
//       TestWidget.routeName,
//     );
// }
    _authCubit.login(LoginRequest(
        email: emailController.text, password: passwordController.text));
    Navigator.of(context).pushNamed(Profile_Screen.routeName);
  }
}
