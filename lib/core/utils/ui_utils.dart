import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:snipp/core/widgets/loading_indicator.dart';

class UIUtils {
  static void showLoading(BuildContext context, [String? pathAnimation]) =>
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => PopScope(
          canPop: false,
          child: pathAnimation!=null? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Lottie.asset('asset/animation/loading.json'),
              
              Text('Loading...',style: TextStyle(fontSize: 30.sp),)
            ],
          ):const  LoadingIndicator()
          // pathAnimation == null
          //           ? const LoadingIndicator()
          //           : Lottie.asset(pathAnimation) 
          
          
          // AlertDialog(
          //   content: SizedBox(
          //       //height: MediaQuery.of(context).size.height * 0.2,
          //       child: 

          //       // const Column(
          //       //   mainAxisAlignment: MainAxisAlignment.center,
          //       //   children: [
          //       //     LoadingIndicator(),
          //       //   ],
          //       // ),  
          //       ),
          // ),
        ),
      );

  static void hideLoading(BuildContext context) => Navigator.of(context).pop();

  static void showMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
