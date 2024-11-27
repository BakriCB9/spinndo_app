import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snipp/core/widgets/loading_indicator.dart';

class UIUtils {
  static void showLoading(BuildContext context, [String? pathAnimation]) =>
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
                      'Please Loading...',
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

  static void hideLoading(BuildContext context) => Navigator.of(context).pop();

  static void showMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
    );
  }
}
