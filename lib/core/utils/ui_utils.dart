import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app/core/widgets/loading_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UIUtils {
  static void showLoading(BuildContext context, [String? pathAnimation]) {
    final localization = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
          canPop: false,
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Theme.of(context).primaryColor),
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LoadingIndicator(Colors.white),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    localization.pleaseLoading,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 25.sp),
                  )
                ],
              ),
            ),
          )),
    );
  }

  static void hideLoading(BuildContext context) => Navigator.of(context).pop();

  static void showMessage(String message) {
    Fluttertoast.showToast(
      backgroundColor: Colors.grey.shade800,
      msg: message,
      toastLength: Toast.LENGTH_LONG,
    );
  }
}
