import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/constant.dart';
import 'package:snipp/core/utils/ui_utils.dart';
import 'package:snipp/features/auth/data/models/resend_code_request.dart';
import 'package:snipp/features/auth/data/models/verify_code_request.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_states.dart';
import 'package:snipp/features/auth/presentation/widget/custom_auth_form.dart';
import 'package:snipp/features/profile/presentation/screens/profile_screen.dart';
import 'package:snipp/features/service/presentation/screens/service_screen.dart';
import 'package:snipp/main.dart';
import '../../../../core/di/service_locator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../drawer/presentation/cubit/drawer_cubit.dart';

class VerficationCodeScreen extends StatelessWidget {
  static const String routeName = '/verfication';

   VerficationCodeScreen({super.key});

  final formKey = GlobalKey<FormState>();

  final _drawerCubit = serviceLocator.get<DrawerCubit>();

  final _authCubit = serviceLocator.get<AuthCubit>()..verifyCodeTime();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final style = Theme.of(context).elevatedButtonTheme.style!;
    return CustomAuthForm(
      canback: true,
      hasTitle: false,
      hasAvatar: false,
      child: SizedBox(
        height: 1200.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(localization.resendCode,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontFamily: "WorkSans")),
            SizedBox(
              height: 20.h,
            ),
            Icon(Icons.email,
                size: 200.h, color: Theme.of(context).primaryColor),
            SizedBox(height: 40.h),
            Text(
              '${localization.enterVerificationCode} ${sharedPref.getString(CacheConstant.emailKey)?? _authCubit.emailController.text}',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontFamily: "WorkSans"),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            Form(
              key: formKey,
              child: TextFormField(
                validator: (p1) {
                  if (p1 == null || p1.length < 6) {
                    return localization.enterCodeFrom6Digit;
                  }
                  return null;
                },
                controller: _authCubit.codeController,
                maxLength: 6,
                maxLines: 1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 32.sp),
                decoration: InputDecoration(
                  hintText: localization.enterCode,
                ),
              ),
            ),
            BlocConsumer<AuthCubit, AuthState>(
              bloc: _authCubit,
              buildWhen: (previous, current) {
                if(current is CanResendState)return true;
                return false;
              },
              builder: (context, state) {
                return Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FittedBox(fit: BoxFit.scaleDown,
                        child: Text(
                            _authCubit.canResend
                                ? localization.didntReciveCode
                                : '${localization.resendCodeIn} ${_authCubit.resendCodeTime} ${localization.seconds}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: ColorManager.black)),
                      ),
                      FittedBox(fit: BoxFit.scaleDown,
                        child: TextButton(
                          onPressed: _authCubit.canResend
                              ? () {
                                  _authCubit.resendCode(ResendCodeRequest(
                                      email: _authCubit.emailController.text));
                                }
                              : null,
                          child: Text(localization.resendCode,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                fontSize: 25.sp,
                                    color: _authCubit.canResend
                                        ? Theme.of(context).primaryColor
                                        : ColorManager.grey,
                                  )),
                        ),
                      ),
                    ],
                  ),
                );
              },
              listener: (BuildContext context, AuthState state) {
                if (state is ResendCodeLoading) {
                  UIUtils.showLoading(context, 'asset/animation/loading.json');
                } else if (state is ResendCodeError) {
                  UIUtils.hideLoading(context);
                  UIUtils.showMessage(state.message);
                } else if (state is ResendCodeSuccess) {
                  UIUtils.hideLoading(context);
                  _authCubit.verifyCodeTime();
                }
              },
            ),
            SizedBox(height: 20.h),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: BlocListener<AuthCubit, AuthState>(
                bloc: _authCubit,
                listener: (contexxt, state) {
                  if (state is VerifyCodeLoading) {
                    UIUtils.showLoading(context);
                  } else if (state is VerifyCodeError) {
                    UIUtils.hideLoading(context);

                    UIUtils.showMessage(state.message);
                    // if (state.message == "The email has already been taken.") {
                    //   Navigator.of(context).pushNamed(
                    //     SignUpScreen.routeName,
                    //   );
                    //   _authCubit.resendCode(ResendCodeRequest(
                    //       email: _authCubit.emailController.text));
                    // }
                  } else if (state is VerifyCodeSuccess) {
                    UIUtils.hideLoading(context);
                    Navigator.of(context)
                        .pushReplacementNamed(ServiceScreen.routeName);
                  }
                },
                child: ElevatedButton(
                  onPressed: _verifyCode,
                  style: style.copyWith(
                      backgroundColor: WidgetStateProperty.all(
                          _drawerCubit.themeMode == ThemeMode.light
                              ? ColorManager.white
                              : ColorManager.primary)),
                  child: Text(localization.verify,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: _drawerCubit.themeMode == ThemeMode.light
                              ? ColorManager.primary
                              : ColorManager.white)),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  _verifyCode() {
    if (formKey.currentState?.validate() == true) {
      _authCubit.verifyCode(VerifyCodeRequest(
          email: _authCubit.emailController.text,
          code: _authCubit.codeController.text));
    }
  }
}
