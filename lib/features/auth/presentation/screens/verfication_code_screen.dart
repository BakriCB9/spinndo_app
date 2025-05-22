import 'package:app/core/const_variable.dart';
import 'package:app/core/routes/routes.dart';
import 'package:app/features/auth/presentation/cubit/cubit/login_cubit.dart';
import 'package:app/features/auth/presentation/cubit/cubit/verification_cubit.dart';
import 'package:app/features/auth/presentation/cubit/cubit/verification_state.dart';
import 'package:app/features/auth/presentation/widget/section_resend_code_timer.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/features/auth/data/models/verify_code_request.dart';
import 'package:app/features/auth/presentation/widget/custom_auth_form.dart';
import 'package:app/features/service/presentation/screens/service_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VerficationCodeScreen extends StatefulWidget {
  String? email;
  TypeVerificationComing? typeComing;
  LoginCubit? loginCubit;
  VerficationCodeScreen(
      {this.email = 'user@gmail.come',
      this.typeComing,
      this.loginCubit,
      super.key});

  @override
  State<VerficationCodeScreen> createState() => _VerficationCodeScreenState();
}

class _VerficationCodeScreenState extends State<VerficationCodeScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final verficyCubit = BlocProvider.of<VerificationCubit>(context);

    final localization = AppLocalizations.of(context)!;

    return CustomAuthForm(
      hasTitle: false,
      hasAvatar: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 60.h,
          ),
          Text(localization.resendCode,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontFamily: "WorkSans")),
          SizedBox(height: 20.h),
          Icon(Icons.email, size: 200.h),
          SizedBox(height: 40.h),
          Text(
            '${localization.enterVerificationCode} ${widget.email ?? ''}',
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontFamily: "WorkSans"),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40.h),
          Form(
            key: formKey,
            child: TextFormField(
              validator: (p1) {
                if (p1 == null || p1.length < 6) {
                  return localization.enterCodeFrom6Digit;
                }
                return null;
              },
              controller: verficyCubit.codeController,
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
          SectionResendCodeTimer(
            email: widget.email!,
            verificationCubit: verficyCubit,
          ),
          SizedBox(height: 50.h),
          SizedBox(
            width: double.infinity,
            child: BlocListener<VerificationCubit, VerificationState>(
              bloc: verficyCubit,
              listenWhen: (pre, cur) {
                if (pre.verifyState != cur.verifyState) {
                  return true;
                }
                return false;
              },
              listener: (contexxt, state) {
                if (state.verifyState is BaseLoadingState) {
                  UIUtils.showLoadingDialog(context);
                } else if (state.verifyState is BaseErrorState) {
                  final result = state.verifyState as BaseErrorState;
                  UIUtils.hideLoading(context);

                  UIUtils.showMessage(result.error!);
                } else if (state.verifyState is BaseSuccessState) {
                  UIUtils.hideLoading(context);
                  if (widget.typeComing ==
                      TypeVerificationComing.comeFromForgetPassword) {
                    Navigator.of(context).pushNamed(Routes.forgetPasswordRoute,
                        arguments: widget.loginCubit);
                  } else {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(ServiceScreen.routeName, (p) {
                      return false;
                    });
                  }

                  //  authCubit!.close();
                }
              },
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() == true) {
                    verficyCubit.verifyCode(VerifyCodeRequest(
                        fcmToken: fcmToken!,
                        email: widget.email ?? '',
                        code: verficyCubit.codeController.text));
                  }
                },
                child: Text(localization.confirm,
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
