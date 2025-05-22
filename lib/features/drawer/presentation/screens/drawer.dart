import 'package:app/features/drawer/presentation/widget/drawer/section_body_drawer.dart';
import 'package:app/features/drawer/presentation/widget/drawer/section_header_drawer.dart';
import 'package:flutter/material.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final _drawerCubit = serviceLocator.get<DrawerCubit>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: _drawerCubit.themeMode == ThemeMode.dark
          ? ColorManager.darkBlue
          : Colors.white,
      child: Column(
        children: [
          const Expanded(flex: 2, child: SectionHeaderDrawer()),
          Expanded(
              flex: 5,
              child: SectionBodyDrawer(
                drawerCubit: _drawerCubit,
              ))
        ],
      ),
    );
  }
}
