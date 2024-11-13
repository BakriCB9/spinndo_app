import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoDetails extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  const InfoDetails(
      {required this.icon,
        required this.title,
        required this.content,
        super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 10.h,
      ),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          color: Colors.white,
          width: double.infinity,
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Icon(icon, color: Colors.grey),
            SizedBox(width: 15.w),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 22.sp,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500)),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(content,
                    style: TextStyle(color: Colors.grey, fontSize: 20.sp)),
              )
            ])
          ])),
      const Divider(color: Colors.grey, thickness: 0.2)
    ]);
  }
}