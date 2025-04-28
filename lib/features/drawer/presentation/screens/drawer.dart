import 'dart:convert';

import 'package:app/core/widgets/cash_network.dart';
import 'package:app/features/discount/presentation/view/add_discount_screen.dart';
import 'package:app/features/drawer/presentation/screens/setting_screen.dart';
import 'package:app/features/favorite/presentation/view/favorite_screen.dart';
import 'package:app/features/service/presentation/cubit/service_cubit.dart';
import 'package:app/features/service_requist/presentation/view/get_service_request_screen.dart';
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

import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../packages/presentation/view/packages_screen.dart';
import '../../data/model/languages.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final _drawerCubit = serviceLocator.get<DrawerCubit>();
  Dio? _dio;
  final _serviceCubit = serviceLocator.get<ServiceCubit>();

  final imagePhoto = sharedPref.getString(CacheConstant.imagePhoto);

  List<Languages> languages = [
    Languages(name: 'English', code: 'en'),
    Languages(name: 'Deutsch', code: 'de'),
    Languages(name: 'العربية', code: 'ar'),
  ];
  Uint8List? bytes;
  final _authCubit = serviceLocator.get<AuthCubit>();


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
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            // barrierColor: Colors.black54,
                            barrierColor: Colors.black.withOpacity(0.6),
                            context: context,
                            builder: (context) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                        width: 500.w,
                                        height: 500.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(300.r)
                                            //color: Colors.grey,
                                            ),
                                        child: Builder(
                                          builder: (context) {
                                            Uint8List? bytes;
                                            final base64String =
                                                sharedPref.getString(
                                                    CacheConstant.imagePhoto);
                                            if (base64String != null &&
                                                base64String.isNotEmpty) {
                                              bytes =
                                                  base64Decode(base64String);
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
                                                            BorderRadius
                                                                .circular(
                                                                    400.r),
                                                        child: CashImage(
                                                            path: imagePhoto)))
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            400.r),
                                                    child: Image.memory(
                                                      bytes!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  );
                                          },
                                        )),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Container(
                          width: 175.w,
                          height: 175.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: Hero(
                            tag: 'image',
                            child: Builder(
                              builder: (context) {
                                Uint8List? bytes;
                                final base64String = sharedPref
                                    .getString(CacheConstant.imagePhoto);
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
                                        borderRadius:
                                            BorderRadius.circular(150.r),
                                        child: Image.memory(
                                          bytes!,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                              },
                            ),
                          )),
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
                    // child: Column(
                    //   children: [],
                    // ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Scaffold.of(context).closeDrawer();
                  //     Navigator.of(context).pushNamed(SettingScreen.routeName);
                  //   },
                  //   child: ListTile(
                  //     leading: const Icon(
                  //       Icons.settings,
                  //       color: ColorManager.primary,
                  //     ),
                  //     title: Text(
                  //       localization.setting,
                  //       style: Theme.of(context)
                  //           .textTheme
                  //           .titleLarge!
                  //           .copyWith(fontSize: 32.sp),
                  //     ),
                  //   ),
                  // ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(Profile_Screen.routeName);
                      Scaffold.of(context).closeDrawer();
                    },
                    child: ListTile(
                      leading: const Icon(
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
                  InkWell(
                    onTap: () {
                      Scaffold.of(context).closeDrawer();
                      Navigator.of(context)
                          .pushNamed(GetServiceRequestScreen.routeName);
                    },
                    child: ListTile(
                      leading: const Icon(
                        Icons.emoji_people,
                        color: ColorManager.primary,
                      ),
                      title: Text(
                        localization.request,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 32.sp),
                      ),
                    ),
                  ),
                  _authCubit.isClient
                      ? InkWell(
                    onTap: () {
                      Scaffold.of(context).closeDrawer();
                      Navigator.of(context)
                          .pushNamed(PackagesScreen.routeName);
                    },
                    child: ListTile(
                      leading: const Icon(
                        Icons.inventory_2_rounded,
                        color: ColorManager.primary,
                      ),
                      title: Text(
                        "Packages",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 32.sp),
                      ),
                    ),
                  )
                      : SizedBox(),
                  getUserRole() != null
                      ? getUserRole() == 'Client'
                      ? SizedBox()
                      : InkWell(
                    onTap: () {
                      Scaffold.of(context).closeDrawer();
                      Navigator.of(context)
                          .pushNamed(DiscountScreen.routeName);
                    },
                    child: ListTile(
                      leading: const Icon(
                        Icons.discount,
                        color: ColorManager.primary,
                      ),
                      title: Text(
                        localization.disco,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 32.sp),
                      ),
                    ),
                  )
                      : const SizedBox(),
                  // getUserRole() != null
                  //     ? getUserRole() == 'Client'
                  //         ? SizedBox()
                  //         :
                  // InkWell(
                  //             onTap: () {
                  //               Scaffold.of(context).closeDrawer();
                  //               Navigator.of(context)
                  //                   .pushNamed(DiscountScreen.routeName);
                  //             },
                  //             child: ListTile(
                  //               leading: const Icon(
                  //                 Icons.discount,
                  //                 color: ColorManager.primary,
                  //               ),
                  //               title: Text(
                  //                 localization.disco,
                  //                 style: Theme.of(context)
                  //                     .textTheme
                  //                     .titleLarge!
                  //                     .copyWith(fontSize: 32.sp),
                  //               ),
                  //             ),
                  //           )
                  //     : const SizedBox(),
                  InkWell(
                    onTap: () {
                      Scaffold.of(context).closeDrawer();
                      Navigator.of(context).pushNamed(FavoriteScreen.routeName);
                    },
                    child: ListTile(
                      leading: const Icon(
                        Icons.favorite,
                        color: ColorManager.primary,
                      ),
                      title: Text(
                        localization.fav,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 32.sp),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Scaffold.of(context).closeDrawer();
                      Navigator.of(context).pushNamed(SettingScreen.routeName);
                    },
                    child: ListTile(
                      leading: const Icon(
                        Icons.settings,
                        color: ColorManager.primary,
                      ),
                      title: Text(
                        localization.setting,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 32.sp),
                      ),
                    ),
                  ),
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
                ],
              )),
        ],
      ),
    );
  }
}

String? getUserRole() {
  return sharedPref.getString(CacheConstant.userRole);
}
