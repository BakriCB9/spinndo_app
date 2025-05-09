import 'package:app/core/utils/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app/core/widgets/loading_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UIUtils {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: const AlertDialog(
            backgroundColor: Colors.transparent,
            content: LoadingWidget(),
          ),
        );
      },
    );
  }

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

// class LoadingWidget extends StatefulWidget {
//   const LoadingWidget({super.key});

//   @override
//   State<LoadingWidget> createState() => _LoadingWidgetState();
// }

// class _LoadingWidgetState extends State<LoadingWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: AnimatedBuilder(
//         animation: _controller,
//         builder: (context, child) {
//           double rotationValue = _controller.value * 2 * 3.14;
//           bool isFlipped =
//               (_controller.value > 0.25 && _controller.value < 0.75);

//           return Transform(
//             transform: Matrix4.identity()
//               ..setEntry(3, 2, 0.001)
//               ..rotateY(rotationValue),
//             alignment: Alignment.center,
//             child: isFlipped
//                 ? Transform(
//                     alignment: Alignment.center,
//                     transform: Matrix4.rotationY(3.14159265359),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(20),
//                       child: SvgPicture.asset(
//                         'asset/images/logo.svg',
//                         width: 50,
//                         height: 50,
//                       ),
//                     ),
//                   )
//                 : ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: SvgPicture.asset(
//                       'asset/images/logo.svg',
//                       width: 50,
//                       height: 50,
//                     ),
//                   ),
//           );
//         },
//       ),
//     );
//   }
// }
