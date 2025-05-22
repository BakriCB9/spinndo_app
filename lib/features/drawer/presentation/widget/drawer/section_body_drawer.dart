import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/routes/routes.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/features/discount/presentation/view/add_discount_screen.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_states.dart';
import 'package:app/features/drawer/presentation/screens/setting_screen.dart';
import 'package:app/features/favorite/presentation/view/favorite_screen.dart';
import 'package:app/features/packages/presentation/view/packages_screen.dart';
import 'package:app/features/profile/presentation/screens/profile_screen.dart';
import 'package:app/features/service_requist/presentation/view/get_service_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SectionBodyDrawer extends StatefulWidget {
  final DrawerCubit drawerCubit;
  const SectionBodyDrawer({required this.drawerCubit, super.key});

  @override
  State<SectionBodyDrawer> createState() => _SectionBodyDrawerState();
}

class _SectionBodyDrawerState extends State<SectionBodyDrawer> {
  String? userRole;
  @override
  void initState() {
    super.initState();
    userRole = getUserRole();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(height: 20.h),
        ItemOfbodyDrawer(
          onClick: () {
            Navigator.of(context).pushNamed(Profile_Screen.routeName);
            Scaffold.of(context).closeDrawer();
          },
          title: localization.profile,
          icon: Icons.person,
        ),
        ItemOfbodyDrawer(
          onClick: () {
            Scaffold.of(context).closeDrawer();
            Navigator.of(context).pushNamed(GetServiceRequestScreen.routeName);
          },
          title: localization.request,
          icon: Icons.emoji_people,
        ),
        userRole != 'Client'
            ? ItemOfbodyDrawer(
                onClick: () {
                  Scaffold.of(context).closeDrawer();
                  Navigator.of(context).pushNamed(PackagesScreen.routeName);
                },
                title: localization.packages,
                icon: Icons.all_inbox,
              )
            : const SizedBox(),
        userRole != 'Client'
            ? ItemOfbodyDrawer(
                onClick: () {
                  Scaffold.of(context).closeDrawer();
                  Navigator.of(context).pushNamed(DiscountScreen.routeName);
                },
                title: localization.disco,
                icon: Icons.discount,
              )
            : const SizedBox(),
        ItemOfbodyDrawer(
            onClick: () {
              Scaffold.of(context).closeDrawer();
              Navigator.of(context).pushNamed(FavoriteScreen.routeName);
            },
            title: localization.fav,
            icon: Icons.favorite),
        ItemOfbodyDrawer(
            onClick: () {
              Scaffold.of(context).closeDrawer();
              Navigator.of(context).pushNamed(SettingScreen.routeName);
            },
            title: localization.setting,
            icon: Icons.settings),
        BlocListener<DrawerCubit, DrawerStates>(
            bloc: widget.drawerCubit,
            listener: (context, state) {
              if (state is LogOutLoading) {
                UIUtils.showLoadingDialog(context);
              } else if (state is LogOutErrorr) {
                UIUtils.hideLoading(context);
                UIUtils.showMessage(state.message);
              } else if (state is LogOutSuccess) {
                UIUtils.hideLoading(context);
                Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
              }
            },
            child: ItemOfbodyDrawer(
                onClick: () {
                  widget.drawerCubit.logout();
                },
                title: localization.logout,
                icon: Icons.logout_outlined)),
      ],
    ));
  }

  String? getUserRole() {
    return serviceLocator
        .get<SharedPreferences>()
        .getString(CacheConstant.userRole);
  }
}

typedef CallBack = void Function()?;

class ItemOfbodyDrawer extends StatelessWidget {
  final CallBack onClick;
  final String title;
  final IconData icon;
  const ItemOfbodyDrawer(
      {required this.onClick,
      required this.title,
      required this.icon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: ListTile(
        leading: Icon(
          icon,
          color: ColorManager.primary,
        ),
        title: Text(
          title,
          style:
              Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 32.sp),
        ),
      ),
    );
  }
}
