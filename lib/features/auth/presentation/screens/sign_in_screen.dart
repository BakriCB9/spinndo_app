import 'package:app/core/const_variable.dart';
import 'package:app/core/resources/font_manager.dart';
import 'package:app/core/routes/routes.dart';
import 'package:app/features/auth/presentation/cubit/cubit/login_cubit.dart';
import 'package:app/features/auth/presentation/cubit/cubit/login_state.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/utils/validator.dart';
import 'package:app/core/widgets/custom_text_form_field.dart';
import 'package:app/features/auth/data/models/login_request.dart';
import 'package:app/features/auth/presentation/widget/custom_auth_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:app/features/service/presentation/screens/service_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final _loginCubit = serviceLocator.get<LoginCubit>();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme
        .of(context)
        .textTheme;
    return CustomAuthForm(
      canBack: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60.h),
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
                      controller: _loginCubit.emailController,
                      icon: Icons.email_outlined,
                      labelText: localization.email,
                    ),
                    SizedBox(height: 30.h),
                    CustomTextFormField(
                      validator: (value) {
                        if (!Validator.isPassword(value)) {
                          return localization.passwordLessThanSix;
                        }
                        if (!RegExp(r'[A-Za-z]').hasMatch(value!)) {
                          return localization.passwordMustContainAtLeastOneLetter;
                        }
                        if (!RegExp(r'\d').hasMatch(value)) {
                          return localization.passwordMustContainAtLeastOneNumber;
                        }
                        return null;
                      },
                      controller: _loginCubit.passwordController,
                      icon: Icons.lock_outline_rounded,
                      isPassword: true,
                      labelText: localization.password,
                    ),
                  ],
                )),
            SizedBox(height: 20.h),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.sendCodeScreen,
                          arguments: _loginCubit);
                      _loginCubit.passwordController.clear();
                      _loginCubit.emailController.clear();
                    },
                    child: Text(localization.forgetPassword,
                        style: theme.titleMedium!
                            .copyWith(fontSize: FontSize.s16,
                            color: ColorManager.primary,fontWeight: FontWeight.w400)))),
            SizedBox(height: 45.h),
            BlocListener<LoginCubit, LoginState>(
              listenWhen: (pre, cur) {
                return pre.loginStatus != cur.loginStatus;
              },
              bloc: _loginCubit,
              listener: (_, state) {
                _checkState(context, state);
              },
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          36),
                    ),
                  ),
                  onPressed: _login,
                  child: Text(localization.login,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36),
                        ),
                        backgroundColor: Theme
                            .of(context)
                            .primaryColorLight
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(ServiceScreen.routeName);
                    },
                    child: Text(
                      localization.guest,
                      style: theme.bodyLarge!.copyWith( fontSize: 30.sp),
                    ))),
            SizedBox(height: 50.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: ColorManager.lightGrey,
                      thickness: 1,
                      endIndent: 8,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      localization.or,
                      style: TextStyle(color: ColorManager.grey),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: ColorManager.lightGrey,
                      thickness: 1,
                      indent: 8,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.registerRoute);
                },
                child: Text(localization.createNewAccount,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight:FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _login() {
    _loginCubit.login(LoginRequest(
        fcmToken: fcmToken ?? '',
        email: _loginCubit.emailController.text,
        password: _loginCubit.passwordController.text));
  }

  _checkState(BuildContext context, LoginState state) {
    if (state.loginStatus is BaseLoadingState) {
      UIUtils.showLoadingDialog(context);
    } else if (state.loginStatus is BaseSuccessState) {
      UIUtils.hideLoading(context);
      Navigator.of(context).pushReplacementNamed(ServiceScreen.routeName);
    } else if (state.loginStatus is BaseErrorState) {
      final message = state.loginStatus as BaseErrorState;
      UIUtils.hideLoading(context);
      UIUtils.showMessage(message.error!);
      if (message.error ==
          "This accouct is Inactive.You must insert verification code from your email.") {
        Navigator.of(context).pushNamed(Routes.verificationRoutes,
            arguments: {'email': _loginCubit.emailController.text});      }
    }
  }
}
