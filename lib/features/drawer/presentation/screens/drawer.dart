import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/core/resources/color_manager.dart';
import 'package:snipp/core/resources/theme_manager.dart';
import 'package:snipp/features/drawer/model/languages.dart';
import 'package:snipp/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomDrawer extends StatelessWidget {
   CustomDrawer({super.key});
  final _drawerCubit = serviceLocator.get<DrawerCubit>();

   List<Languages> languages = [
     Languages(name: 'English', code: 'en'),
     Languages(name: 'العربية', code: 'ar'),
   ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150.w,
                      height: 150.h,
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
                      title: Text(
                        'Bakri aweja',
                        style: TextStyle(fontSize: 30.sp, color: Colors.white),
                      ),
                      subtitle: Text(
                        'bakkaraweja@gmail.com',
                        style: TextStyle(fontSize: 25.sp, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(_drawerCubit.themeMode == ThemeMode.dark
                          ? AppLocalizations.of(context)!.firstName
                          : AppLocalizations.of(context)!.firstName, style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge),
                    ),
                    Expanded(
                      child: Switch(
                        activeColor: ColorManager.primary,
                        activeTrackColor: ColorManager.secondPrimary,
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
                      child: Text(AppLocalizations.of(context)!.firstName,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyLarge),
                    ),
                    Expanded(
                      child: SizedBox(
                        width:90.w,
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton<Languages>(
                                value: languages.firstWhere(
                                      (lang) =>
                                  lang.code == _drawerCubit.languageCode,
                                ),
                                items: languages
                                    .map(
                                      (language) =>
                                      DropdownMenuItem<Languages>(
                                        value: language,
                                        child: Text(language.name,
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(fontWeight: FontWeight.w500)),
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
                                    ? ColorManager.green
                                    : ColorManager.white)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const Expanded(
              flex: 3,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile'),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Setting'),
                  ),
                  ListTile(
                    leading: Icon(Icons.login_outlined),
                    title: Text('Log out'),
                  )

                ],
              )),

        ],
      ),
    );
  }
}