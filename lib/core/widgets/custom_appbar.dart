import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key, this.appBarText, this.canBack = true});
  final String? appBarText;
  final bool canBack;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        canBack
            ? InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.black,
                  size: 45.sp,
                ))
            : const SizedBox(),
        SizedBox(
          width: 40.w,
        ),
        Text(
          appBarText ?? "",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
