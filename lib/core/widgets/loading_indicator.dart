import 'package:app/core/di/service_locator.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final Color? color;
  const LoadingIndicator(this.color);

  @override
  Widget build(BuildContext context) {
    final _drawerCubit = serviceLocator.get<DrawerCubit>();

    return Container(
      decoration: _drawerCubit.themeMode == ThemeMode.dark
          ? BoxDecoration(
          image: DecorationImage(
              image: AssetImage("asset/images/bg.png"), fit: BoxFit.fill))
          : null,
      child: Center(
        child: CircularProgressIndicator(
          color: color ?? Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
