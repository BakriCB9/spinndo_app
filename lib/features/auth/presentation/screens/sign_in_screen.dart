import 'package:app/core/const_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/utils/validator.dart';
import 'package:app/core/widgets/custom_text_form_field.dart';
import 'package:app/features/auth/data/models/login_request.dart';
import 'package:app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app/features/auth/presentation/cubit/auth_states.dart';
import 'package:app/features/auth/presentation/screens/verfication_code_screen.dart';
import 'package:app/features/auth/presentation/widget/custom_auth_form.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:app/features/service/presentation/screens/service_screen.dart';
import 'forget_password_screen.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  static const String routeName = '/signin';

  final formKey = GlobalKey<FormState>();

  final _authCubit = serviceLocator.get<AuthCubit>();

  final _drawerCubit = serviceLocator.get<DrawerCubit>();

  @override
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final style = Theme.of(context).elevatedButtonTheme.style!;
    return CustomAuthForm(
      canBack: false,
      isGuest: true,
      child: Column(
        children: [
          SizedBox(
            height: 60.h,
          ),
          Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    validator: (value) {
                      if (!Validator.isEmail(value)) {
                        return localization.validEmail;
                      }
                      return null;
                    },
                    controller: _authCubit.emailController,
                    icon: Icons.email,
                    labelText: localization.email,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomTextFormField(
                    validator: (value) {
                      if (!Validator.isPassword(value)) {
                        return localization.passwordLessThanSix;
                      }
                      return null;
                    },
                    controller: _authCubit.passwordController,
                    icon: Icons.lock,
                    isPassword: true,
                    labelText: localization.password,
                  ),
                ],
              )),
          SizedBox(
            height: 20.h,
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ForgotPasswordScreen.routeName);
                    _authCubit.passwordController.clear();
                    _authCubit.confirmPasswordController.clear();
                    _authCubit.emailController.clear();
                  },
                  child: Text(localization.forgetPassword,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: ColorManager.primary))),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          BlocListener(
            bloc: _authCubit,
            listener: (_, state) {
              if (state is LoginLoading) {
                UIUtils.showLoading(context);
              } else if (state is LoginSuccess) {
                UIUtils.hideLoading(context);

                //  _authCubit.close();
                _authCubit.emailController.clear();
                _authCubit.passwordController.clear();
                Navigator.of(context)
                    .pushReplacementNamed(ServiceScreen.routeName);
              } else if (state is LoginError) {
                UIUtils.hideLoading(context);
                UIUtils.showMessage(state.message);
                if (state.message ==
                    "This accouct is Inactive.You must insert verification code from your email.") {
                  Navigator.of(context)
                      .pushNamed(VerficationCodeScreen.routeName);
                }
              }
            },
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _login,
                child: Text(localization.login,
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Center(
            child: InkWell(
              onTap: () {
                _authCubit.emailController.clear();
                _authCubit.passwordController.clear();
                Navigator.of(context)
                    .pushReplacementNamed(SignUpScreen.routeName);
              },
              child: Text(localization.createNewAccount,
                  style: Theme.of(context).textTheme.titleMedium),
            ),
          ),
        ],
      ),
    );
  }

  _login() {
    print(
        'the value of login is ${_authCubit.emailController} and ${_authCubit.passwordController.text}');
    print(
        'the value of fcm token is &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&  ${fcmToken}');
    _authCubit.login(LoginRequest(
        fcmToken: fcmToken!,
        email: _authCubit.emailController.text,
        password: _authCubit.passwordController.text));
  }
}
