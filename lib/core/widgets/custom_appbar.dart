import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/resources/font_manager.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
    required this.appBarText,
    this.canBack = true,
  });

  final String? appBarText;
  final bool canBack;

  @override
  Widget build(BuildContext context) {
    final drawerCubit = serviceLocator.get<DrawerCubit>();

    return Padding(
      padding:  EdgeInsets.all(20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          canBack
              ? InkWell(
                onTap: () => Navigator.of(context).pop(),
                child:Padding(
                  padding:  EdgeInsets.symmetric(horizontal:15.w,vertical: 20.h),
                  child: Icon(Icons.arrow_back_ios_rounded,color: ColorManager.grey,),
                )

              )
              : const SizedBox(width: 20),
          SizedBox(width: 20.w),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Directionality.of(context) == TextDirection.rtl
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Text(
                appBarText ?? 'AppBar',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: FontSize.s22,fontWeight: FontWeight.w600),

              ),
            ),
          ),
        ],
      ),
    );
  }
}
