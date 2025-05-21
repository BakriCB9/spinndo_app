import 'package:app/core/routes/routes.dart';
import 'package:app/features/auth/presentation/cubit/cubit/login_cubit.dart';
import 'package:app/features/auth/presentation/cubit/cubit/login_state.dart';
import 'package:app/features/auth/presentation/widget/custom_auth_form.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/utils/validator.dart';
import 'package:app/core/widgets/custom_text_form_field.dart';
import 'package:app/features/auth/data/models/reset_password_request.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _loginCubit = BlocProvider.of<LoginCubit>(context);
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context).textTheme;
    return CustomAuthForm(
      hasAvatar: false,
      hasTitle: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(localization.resetPassword,
                    style: theme.titleLarge!.copyWith(fontFamily: "WorkSans")),
                SizedBox(height: 4.h),
                Text(localization.resetPasswordTitle,
                    style: theme.bodySmall!.copyWith(fontFamily: "WorkSans")),
              ],
            ),
            SizedBox(height: 30.h),
            Align(
                alignment: Alignment.center,
                child: Icon(Icons.lock_reset, size: 200.sp)),
            SizedBox(height: 50.h),
            Text(
              localization.emailResetPassword,
              style: theme.bodySmall!.copyWith(fontFamily: "WorkSans"),
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
                    controller: _loginCubit.emailController,
                    icon: Icons.email,
                    labelText: localization.email,
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    localization.newPasswordTitle,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 30.h),
                  CustomTextFormField(
                    validator: (value) {
                      if (!Validator.isPassword(value)) {
                        return localization.passwordLessThanSix;
                      }
                      return null;
                    },
                    controller: _loginCubit.passwordController,
                    icon: Icons.lock,
                    isPassword: true,
                    labelText: localization.newPassword,
                  ),
                  SizedBox(height: 30.h),
                  CustomTextFormField(
                    validator: (value) {
                      if (!Validator.isPassword(value)) {
                        return localization.passwordLessThanSix;
                      } else if (_loginCubit.passwordController.text !=
                          _loginCubit.confirmPasswordController.text) {
                        return localization.passwordNotMatched;
                      }
                      return null;
                    },
                    controller: _loginCubit.confirmPasswordController,
                    icon: Icons.lock,
                    isPassword: true,
                    labelText: localization.confirmNewPassword,
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h),
            BlocListener<LoginCubit, LoginState>(
              bloc: _loginCubit,
              listener: (context, state) {
                _checkState(context, state);
              },
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() == true) {
                      _loginCubit.resetPassword(ResetPasswordRequest(
                          _loginCubit.passwordController.text,
                          email: _loginCubit.emailController.text));
                    }
                  },
                  child: Text(localization.verify,
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _checkState(BuildContext context, LoginState state) {
    if (state.resetStatus is BaseLoadingState) {
      UIUtils.showLoadingDialog(context);
    } else if (state.resetStatus is BaseErrorState) {
      final result = state.resetStatus as BaseErrorState;
      UIUtils.hideLoading(context);
      UIUtils.showMessage(result.error!);
    } else if (state.resetStatus is BaseSuccessState) {
      UIUtils.hideLoading(context);
      Navigator.of(context).pushNamed(Routes.loginRoute);
    }
  }
}
