import 'dart:io';

import 'package:app/core/resources/color_manager.dart';
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
      height: 50.h,
      decoration: BoxDecoration(
          border: Border(
              bottom: active
                  ? BorderSide(
                      color: Theme.of(context).primaryColor, width: 2.w)
                  : BorderSide.none)),
      child: Text(text,

          textAlign: TextAlign.center,
          style:active? Theme.of(context).textTheme.labelMedium?.copyWith(color:ColorManager.primary,fontWeight: FontWeight.w700):
          Theme.of(context).textTheme.labelMedium?.copyWith(color:ColorManager.grey)
      ),
    );
  }
}
