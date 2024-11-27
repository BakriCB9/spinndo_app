import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/constant.dart';
import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/core/resources/color_manager.dart';
import 'package:snipp/core/resources/theme_manager.dart';
import 'package:snipp/core/utils/ui_utils.dart';
import 'package:snipp/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:snipp/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snipp/features/drawer/presentation/cubit/drawer_states.dart';
import 'package:snipp/features/profile/presentation/screens/profile_screen.dart';
import 'package:snipp/main.dart';

import '../../data/model/languages.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});
  final _drawerCubit = serviceLocator.get<DrawerCubit>();
  Dio? _dio;

  List<Languages> languages = [
    Languages(name: 'English', code: 'en'),
    Languages(name: 'العربية', code: 'ar'),
  ];
  @override
  Widget build(BuildContext context) {
    final email = sharedPref.getString(CacheConstant.semailKey);
    final name = sharedPref.getString(CacheConstant.nameKey);
    return Drawer(
      backgroundColor: _drawerCubit.themeMode == ThemeMode.dark
          ? ColorManager.darkBlue
          : Colors.white,
      child: Column(
        children: [
          Expanded(flex: 2,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: ColorManager.primary,
              ),
              child: Padding(
                padding:  EdgeInsets.only(left: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // SizedBox(height: 100.h,),
                    Container(
                      width: 175.w,
                      height: 175.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('asset/images/no_profile.png'),
                            fit: BoxFit.cover),
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                    // Text(
                    //   'Bakri aweja',
                    //   style: TextStyle(fontSize: 30.sp, color: Colors.white),
                    // ),
                    // Text(
                    //   'bakkaraweja@gmail.com',
                    //   style: TextStyle(fontSize: 20.sp, color: Colors.white),
                    // )
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(name ?? 'User',
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).primaryColorLight)),
                      subtitle: Text(email ?? 'User@gmail.com',
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).primaryColorLight)),
                    ),SizedBox(height: 10.h,)
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 5,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text("Theme Mood",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontSize: 36.sp)),
                            ),
                            Expanded(
                              child: Switch(
                                activeColor: ColorManager.primary,
                                activeTrackColor: ColorManager.black,
                                value: _drawerCubit.themeMode == ThemeMode.dark,
                                onChanged: (value) {
                                  if (value) {
                                    _drawerCubit.changeTheme(ThemeMode.dark);
                                  } else {
                                    _drawerCubit.changeTheme(ThemeMode.light);
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text("language",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(fontSize: 36.sp))),
                            Expanded(
                              child: SizedBox(
                                width: 90.w,
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton<Languages>(
                                        value: languages.firstWhere(
                                              (lang) =>
                                          lang.code == _drawerCubit.languageCode,
                                        ),
                                        style: Theme.of(context).textTheme.displayMedium,
                                        items: languages
                                            .map(
                                              (language) => DropdownMenuItem<Languages>(
                                            value: language,
                                            child: Text(language.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium),
                                          ),
                                        )
                                            .toList(),
                                        onChanged: (selectedLanguage) {
                                          if (selectedLanguage != null) {
                                            _drawerCubit
                                                .changeLanguage(selectedLanguage.code);
                                          }
                                        },
                                        borderRadius: BorderRadius.circular(25),
                                        dropdownColor:
                                        _drawerCubit.themeMode == ThemeMode.dark
                                            ? ColorManager.darkBlue
                                            : ColorManager.white)),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(Profile_Screen.routeName);
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        color: ColorManager.primary,
                      ),
                      title: Text('Profile',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 32.sp)),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: ColorManager.primary,
                    ),
                    title: Text('Setting',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 32.sp)),
                  ),
                  BlocListener<DrawerCubit,DrawerStates>(
  listener: (context, state) {
  if(state is LogOutLoading){
    UIUtils.showLoading(context);
  }else if(state is LogOutErrorr){
    UIUtils.hideLoading(context);
    UIUtils.showMessage(state.message);
  }else if(state is LogOutSuccess){
    UIUtils.hideLoading(context);
    Navigator.of(context).pushReplacementNamed(SignInScreen.routeName);
  }
  },
  child: InkWell(
                    onTap: () {
                      _drawerCubit.logout();
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.login_outlined,
                        color: ColorManager.primary,
                      ),
                      title: Text('Log out',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 32.sp)),
                    ),
                  ),
)
                ],
              )),
        ],
      ),
    );
  }
}
