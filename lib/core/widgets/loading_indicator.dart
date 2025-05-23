import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final Color? color;
  final bool? isBackGround;
  const LoadingIndicator(this.color, {this.isBackGround = false});

  @override
  Widget build(BuildContext context) {
    final drawerCubit = serviceLocator.get<DrawerCubit>();

    return isBackGround == true
        ? Container(
      decoration: drawerCubit.themeMode == ThemeMode.dark
          ? const BoxDecoration(
        color: ColorManager.darkBg,)
          : null,
            child: Center(
              child: CircularProgressIndicator(
                color: color ?? Theme.of(context).primaryColor,
              ),
            ),
          )
        : Center(
            child: CircularProgressIndicator(
              color: color ?? Theme.of(context).primaryColor,
            ),
          );
  }
}
