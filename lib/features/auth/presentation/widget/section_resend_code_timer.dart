import 'dart:async';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/features/auth/data/models/resend_code_request.dart';
import 'package:app/features/auth/presentation/cubit/cubit/verification_cubit.dart';
import 'package:app/features/auth/presentation/cubit/cubit/verification_state.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SectionResendCodeTimer extends StatefulWidget {
  final VerificationCubit verificationCubit;
  final String email;
  const SectionResendCodeTimer(
      {required this.verificationCubit, required this.email, super.key});

  @override
  State<SectionResendCodeTimer> createState() => _SectionResendCodeTimerState();
}

class _SectionResendCodeTimerState extends State<SectionResendCodeTimer> {
  int validateDurationCode = 70;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() {
    validateDurationCode = 70;
    timer = Timer.periodic(const Duration(seconds: 1), (value) {
      if (validateDurationCode == 0) {
        setState(() {
          timer!.cancel();
          // validateDurationCode = 90;
        });
      } else {
        setState(() {
          validateDurationCode--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return BlocListener<VerificationCubit, VerificationState>(
      listenWhen: (pre, cur) {
        if (pre.resendCodeState != cur.resendCodeState) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        if (state.resendCodeState is BaseLoadingState) {
          UIUtils.showLoadingDialog(context);
        } else if (state.resendCodeState is BaseErrorState) {
          final message = state.resendCodeState as BaseErrorState;
          UIUtils.hideLoading(context);
          UIUtils.showMessage(message.error!);
          startTime();
        } else if (state.resendCodeState is BaseSuccessState) {
          UIUtils.hideLoading(context);
          startTime();
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
                validateDurationCode == 0
                    ? localization.didntReciveCode
                    : '${localization.resendCodeIn} $validateDurationCode ${localization.seconds}',
                style: Theme.of(context).textTheme.titleMedium!),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: TextButton(
              onPressed: validateDurationCode == 0
                  ? () {
                      widget.verificationCubit
                          .resendCode(ResendCodeRequest(email: widget.email));
                    }
                  : null,
              child: Text(localization.resendCode,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 25.sp,
                        color: validateDurationCode == 0
                            ? ColorManager.primary
                            : ColorManager.grey,
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
