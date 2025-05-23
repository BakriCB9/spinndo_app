import 'package:app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';


class CustomAuthForm extends StatelessWidget {
  CustomAuthForm({
    super.key,
    required this.child,
    this.isGuest = false,
    this.hasTitle = true,
    this.hasAvatar = true,
    this.canBack = true,
  });

  final bool isGuest;
  final bool hasAvatar;
  final bool hasTitle;
  final Widget child;
  final bool canBack;

  @override
  Widget build(BuildContext context) {
    final drawerCubit = serviceLocator.get<DrawerCubit>();

    return Container(
      decoration: drawerCubit.themeMode == ThemeMode.dark
          ? const BoxDecoration(
              color: ColorManager.darkBg,
            )
          : null,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      canBack
                          ? InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Theme.of(context).primaryColorLight,
                                  size: 45.sp,
                                ),
                              ))
                          : const SizedBox(),
                      const Spacer(),
                      
                    ],
                  ),
                  SizedBox(height: 80.h),
                  hasAvatar
                      ? CircleAvatar(
                          radius: 170.r,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(200.r),
                              child: SvgPicture.asset("asset/images/logo.svg")))
                      : const SizedBox(),
                  child
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
