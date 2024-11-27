import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/resources/color_manager.dart';

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
          width: double.infinity,
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Icon(icon, color:  Theme.of(context).primaryColorLight),
            SizedBox(width: 15.w),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title,
                   style: Theme.of(context).textTheme.labelSmall),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(content,
                    style: Theme.of(context).textTheme.labelMedium),
              )
            ])
          ])),
      const Divider(color: Colors.grey, thickness: 0.2)
    ]);
  }
}