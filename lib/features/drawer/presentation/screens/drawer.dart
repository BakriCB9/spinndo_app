import 'dart:convert';

import 'package:app/core/resources/assets_manager.dart';
import 'package:app/core/widgets/cash_network.dart';
import 'package:app/features/service/presentation/cubit/service_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';

import 'package:app/core/utils/ui_utils.dart';
import 'package:app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_states.dart';
import 'package:app/features/profile/presentation/screens/profile_screen.dart';
import 'package:app/main.dart';

import '../../data/model/languages.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});
  final _drawerCubit = serviceLocator.get<DrawerCubit>();
  Dio? _dio;
  final _serviceCubit = serviceLocator.get<ServiceCubit>();

  final imagePhoto = sharedPref.getString(CacheConstant.imagePhoto);

  List<Languages> languages = [
    Languages(name: 'English', code: 'en'),
    Languages(name: 'العربية', code: 'ar'),
  ];
  Uint8List? bytes;
  @override
  Widget build(BuildContext context) {
    final imagePhoto = sharedPref.getString(CacheConstant.imagePhotoFromLogin);
    print('the image phto is $imagePhoto');
    final email = sharedPref.getString(CacheConstant.semailKey);
    final name = sharedPref.getString(CacheConstant.nameKey);
    final localization = AppLocalizations.of(context)!;

    final base64String = sharedPref.getString(CacheConstant.imagePhoto);

    return Drawer(
      backgroundColor: _drawerCubit.themeMode == ThemeMode.dark
          ? ColorManager.darkBlue
          : Colors.white,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: ColorManager.primary,
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // SizedBox(height: 100.h,),
                    Container(
                        width: 175.w,
                        height: 175.h,
                        decoration: const BoxDecoration(
                          // image: DecorationImage(
                          //     image: AssetImage('asset/images/no_profile.png'),
                          //     fit: BoxFit.cover),
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: Builder(
                          builder: (context) {
                            Uint8List? bytes;
                            final base64String =
                                sharedPref.getString(CacheConstant.imagePhoto);

                            if (base64String != null &&
                                base64String.isNotEmpty) {
                              bytes = base64Decode(base64String);
                              print(
                                  'the image is ##############################################  $bytes');
                            }
                            return base64String == null
                                ? (imagePhoto == null
                                    ? Icon(
                                        Icons.person,
                                        size: 150.r,
                                        color: Colors.white,
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(300.r),
                                        child: CashImage(path: imagePhoto)))
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(150.r),
                                    child: Image.memory(
                                      bytes!,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                          },
                        )
                        //   base64String==null? (imagePhoto==null?ClipRRect(
                        //       borderRadius: BorderRadius.circular(175.r),
                        //       child: Image.asset('asset/images/no_profile.png')):ClipRRect(
                        //       borderRadius: BorderRadius.circular(175.r),
                        //       child: CashImage(path:imagePhoto)),
                        // ):

                        // Image.memory(
                        //        bytes!,
                        //       fit: BoxFit.cover,
                        //      )
                        ),

                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(name ?? localization.user,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  color: Theme.of(context).primaryColorLight)),
                      subtitle: Text(email ?? 'User@gmail.com',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  color: Theme.of(context).primaryColorLight)),
                    ),
                    SizedBox(
                      height: 10.h,
                    )
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
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Text(localization.themeMood,
                        //           style: Theme.of(context)
                        //               .textTheme
                        //               .titleLarge!
                        //               .copyWith(fontSize: 36.sp)),
                        //     ),
                        //     Expanded(
                        //       child: Switch(
                        //         activeColor: ColorManager.primary,
                        //         activeTrackColor: ColorManager.black,
                        //         value: _drawerCubit.themeMode == ThemeMode.dark,
                        //         onChanged: (value) {
                        //           if (value) {
                        //             _drawerCubit.changeTheme(ThemeMode.dark);
                        //           } else {
                        //             _drawerCubit.changeTheme(ThemeMode.light);
                        //           }
                        //         },
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //         child: Text(localization.language,
                        //             style: Theme.of(context)
                        //                 .textTheme
                        //                 .titleLarge!
                        //                 .copyWith(fontSize: 36.sp))),
                        //     Expanded(
                        //       child: SizedBox(
                        //         width: 90.w,
                        //         child: DropdownButtonHideUnderline(
                        //             child: DropdownButton<Languages>(
                        //                 value: languages.firstWhere(
                        //                   (lang) =>
                        //                       lang.code ==
                        //                       _drawerCubit.languageCode,
                        //                 ),
                        //                 style: Theme.of(context)
                        //                     .textTheme
                        //                     .displayMedium,
                        //                 items: languages
                        //                     .map(
                        //                       (language) =>
                        //                           DropdownMenuItem<Languages>(
                        //                         value: language,
                        //                         child: Text(language.name,
                        //                             style: Theme.of(context)
                        //                                 .textTheme
                        //                                 .displayMedium),
                        //                       ),
                        //                     )
                        //                     .toList(),
                        //                 onChanged: (selectedLanguage) {
                        //                   if (selectedLanguage != null) {
                        //                     _drawerCubit.changeLanguage(
                        //                         selectedLanguage.code);
                        //                   }
                        //                 },
                        //                 borderRadius: BorderRadius.circular(25),
                        //                 dropdownColor: _drawerCubit.themeMode ==
                        //                         ThemeMode.dark
                        //                     ? ColorManager.darkBlue
                        //                     : ColorManager.white)),
                        //       ),
                        //     )
                        //   ],
                        // )
                      ],
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent, // Remove divider color
                    ),
                    child: ExpansionTile(
                      // expandedAlignment: Alignment.centerLeft,
                      leading: Icon(
                        Icons.settings,
                        color: ColorManager.primary,
                      ),
                      tilePadding: EdgeInsets.symmetric(
                          horizontal: 10.w), // Remove padding for seamless look
                      collapsedBackgroundColor:
                          Colors.transparent, // Match the background
                      backgroundColor: Colors.transparent,
                      title: Text(
                        'Setting',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 32.sp),
                      ),

                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(localization.themeMood,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(fontSize: 28.sp)),
                              ),
                              Expanded(
                                child: Switch(
                                  activeColor: ColorManager.primary,
                                  activeTrackColor: ColorManager.black,
                                  value:
                                      _drawerCubit.themeMode == ThemeMode.dark,
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
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(localization.language,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(fontSize: 28.sp))),
                              Expanded(
                                child: SizedBox(
                                  width: 90.w,
                                  child: DropdownButtonHideUnderline(
                                      child: DropdownButton<Languages>(
                                          value: languages.firstWhere(
                                            (lang) =>
                                                lang.code ==
                                                _drawerCubit.languageCode,
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                          items: languages
                                              .map(
                                                (language) =>
                                                    DropdownMenuItem<Languages>(
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
                                              _drawerCubit.changeLanguage(
                                                  selectedLanguage.code);
                                            }
                                          },
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          dropdownColor:
                                              _drawerCubit.themeMode ==
                                                      ThemeMode.dark
                                                  ? ColorManager.darkBlue
                                                  : ColorManager.white)),
                                ),
                              )
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(Profile_Screen.routeName);
                      Scaffold.of(context).closeDrawer();
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        color: ColorManager.primary,
                      ),
                      title: Text(localization.profile,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 32.sp)),
                    ),
                  ),

                  // ListTile(
                  //   leading: Icon(
                  //     Icons.settings,
                  //     color: ColorManager.primary,
                  //   ),
                  //   title: Text(localization.setting,
                  //       style: Theme.of(context)
                  //           .textTheme
                  //           .titleLarge!
                  //           .copyWith(fontSize: 32.sp)),
                  // ),
                  
                        
                  BlocListener<DrawerCubit, DrawerStates>(
                    listener: (context, state) {
                      if (state is LogOutLoading) {
                        UIUtils.showLoading(context);
                      } else if (state is LogOutErrorr) {
                        UIUtils.hideLoading(context);
                        UIUtils.showMessage(state.message);
                      } else if (state is LogOutSuccess) {
                        UIUtils.hideLoading(context);

                        Navigator.of(context)
                            .pushReplacementNamed(SignInScreen.routeName);
                        //  _disposeResources();
                        _serviceCubit.resetSetting();
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
                        title: Text(localization.logout,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 32.sp)),
                      ),
                    ),
                  ),
                  BlocListener<DrawerCubit,DrawerStates>(
                    bloc: _drawerCubit,
                    listener: (context,state){
                      if(state is DeleteAccountLoading){
                        UIUtils.showLoading(context);
                      }
                      else if (state is DeleteAccountError){
                        UIUtils.hideLoading(context);
                        UIUtils.showMessage(state.message);
                      }
                      else if (state is DeleteAccountSuccess){
                        UIUtils.hideLoading(context);
                        Navigator.of(context).pushReplacementNamed(SignInScreen.routeName);
                      }
                    },
                    child: InkWell(
                            onTap: (){
                              _drawerCubit.deleteAccount();
                            },
                            child: ListTile(
                              leading:const  Icon(Icons.delete,color: ColorManager.primary,),
                              title: Text('Delete Account',style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(fontSize: 32.sp)),),
                          ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
  // void _disposeResources() {
  //   _serviceCubit.close();
  //   _drawerCubit.close();
  // }
}
