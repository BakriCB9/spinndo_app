import 'package:app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef VoidCallback = void Function()?;

class ErrorNetworkWidget extends StatelessWidget {
  final String message;
  final VoidCallback onTap;
  const ErrorNetworkWidget(
      {required this.message, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
   final localization = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('asset/animation/error_lottie.json'),
        SizedBox(height: 40.h),
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(height: 20.h),
        OutlinedButton(
          onPressed:onTap,
          child: Text(
            localization.tryagain,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: ColorManager.primary),
          ),
        ),
      ],
    );
  }
}
