import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
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
    final isDarkMode = drawerCubit.themeMode == ThemeMode.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        canBack
            ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: SvgPicture.asset(
              'asset/icons/back.svg',
              width: 20,
              height: 20,
              colorFilter: isDarkMode? ColorFilter.mode(
                ColorManager.primary,
                BlendMode.srcIn,
              ): ColorFilter.mode(
                Color(0xFF9E9E9E),
                BlendMode.srcIn,
              )
            ),
          ),
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
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
