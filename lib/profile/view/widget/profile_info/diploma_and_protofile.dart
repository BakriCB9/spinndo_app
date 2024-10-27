import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiplomaAndProtofile extends StatelessWidget {
  final String text;
  final bool active;
  final int type;
  const DiplomaAndProtofile(
      {required this.active,
      required this.type,
      required this.text,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      decoration: BoxDecoration(
          border: Border(
              bottom: active
                  ? BorderSide(color: Colors.blue, width: 2.w)
                  : BorderSide.none)),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 14.sp,
            color: Colors.blue,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
