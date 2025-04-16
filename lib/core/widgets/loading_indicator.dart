import 'package:app/core/di/service_locator.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final Color? color;
  final bool? isBackGround;
  const LoadingIndicator(this.color, {this.isBackGround = false});

  @override
  Widget build(BuildContext context) {
    final _drawerCubit = serviceLocator.get<DrawerCubit>();

    return isBackGround == true
        ? Container(
            decoration: _drawerCubit.themeMode == ThemeMode.dark
                ? const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("asset/images/bg.png"),
                        fit: BoxFit.fill))
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
