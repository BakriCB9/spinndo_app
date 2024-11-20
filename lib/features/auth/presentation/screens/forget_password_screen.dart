import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/core/utils/ui_utils.dart';
import 'package:snipp/core/utils/validator.dart';
import 'package:snipp/core/widgets/custom_text_form_field.dart';
import 'package:snipp/features/auth/data/models/reset_password_request.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_states.dart';
import 'package:snipp/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:snipp/features/auth/presentation/widget/custom_auth_form.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  static const String routeName = '/forget';

  final _authCubit = serviceLocator.get<AuthCubit>();

  final formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =TextEditingController();
  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {final localization = AppLocalizations.of(context)!;
    return CustomAuthForm(hasAvatar: false,hasTitle: false,child:
    Container(
      height: 1200.h,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localization.resetPassword,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(fontFamily: "WorkSans")
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                 localization.resetPasswordTitle,
                  style:
                  Theme.of(context).textTheme.bodySmall!.copyWith(fontFamily: "WorkSans")
                ),
              ],
            ),
            Expanded(child: Align(alignment: Alignment.center,child: Icon(Icons.lock_reset, size: 200.sp, color: Theme.of(context).primaryColor))),
            SizedBox(height: 50.h),
            Text(
             localization.emailResetPassword,
              style:                Theme.of(context).textTheme.bodySmall!.copyWith(fontFamily: "WorkSans")
      ,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 20.h),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(height: 50.h),
                  Text(
                    localization.newPasswordTitle,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 20.h),
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
                    labelText: localization.newPassword,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextFormField(
                    validator: (value) {
                      if (!Validator.isPassword(value)) {
                        return localization.passwordLessThanSix;
                      } else if (_authCubit.passwordController.text !=
                          _authCubit.confirmPasswordController.text) {
                        return localization.passwordNotMatched;
                      }
                      return null;
                    },
                    controller: _authCubit.confirmPasswordController,
                    icon: Icons.lock,
                    isPassword: true,
                    labelText: localization.confirmNewPassword,
                  ),
                ],
              ),

            ),
Spacer(),
            BlocListener<AuthCubit  , AuthState>(
              bloc: _authCubit,
          listener: (context, state) {
            if (state is ResetPasswordLoading) {
              UIUtils.showLoading(context,'asset/animation/loading.json');
            } else if (state is ResetPasswordError) {
              UIUtils.hideLoading(context);
              UIUtils.showMessage(state.message);
            } else if (state is ResetPasswordSuccess) {
              UIUtils.hideLoading(context);
              Navigator.of(context).pushNamed(SignInScreen.routeName);

            }
          },
          child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 40.h),
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() == true) {
                  _authCubit.resetPassword(ResetPasswordRequest(_authCubit.passwordController.text, email: _authCubit.emailController.text));

                  }
                },

                child: Text(localization.verify,
                    style: Theme.of(context).textTheme.bodyLarge
              ),
            ),
        ),
            )],
        ),
    ),
    );
  }
}
