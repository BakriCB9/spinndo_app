import 'package:app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
typedef OnChooseType =void Function()?;
class SectionItemsOfShowModelBottom extends StatelessWidget {
 final  String title;
 final  OnChooseType select;
  
  const SectionItemsOfShowModelBottom({required this.select,required this.title,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: select,
          child: Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
                shape: BoxShape.circle, border: Border.all(color: Colors.grey)),
            child: const Icon(
              Icons.image_outlined,
              color: ColorManager.primary,
            ),
          ),
        ),
        SizedBox(height: 15.h),
        Text(
          title,
          style:
              Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 25.sp),
        )
      ],
    );
  }
}
