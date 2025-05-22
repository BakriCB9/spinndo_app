import 'package:app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
typedef VoidCallback =  void Function()?;
class ErrorLocationWidget extends StatelessWidget {
  final VoidCallback getCurrentLocation;
  const ErrorLocationWidget({required this.getCurrentLocation, super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                Icons.location_off_rounded,
                color: ColorManager.primary,
                size: 300.w,
              ),
              Text(localization.giveAccessPersmissionLocation,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center),
              SizedBox(height: 50.h),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: getCurrentLocation,
                      child: Text(localization.tryagain)))
            ])));
  }
}
