import 'dart:io';
import 'dart:ui';

import 'package:app/core/routes/routes.dart';
import 'package:app/core/utils/app_shared_prefrence.dart';
import 'package:app/core/widgets/cash_network.dart';
import 'package:app/features/discount/presentation/view/add_discount_screen.dart';
import 'package:app/features/drawer/presentation/screens/setting_screen.dart';
import 'package:app/features/favorite/presentation/view/favorite_screen.dart';
import 'package:app/features/service/presentation/cubit/service_cubit.dart';
import 'package:app/features/service_requist/presentation/view/get_service_request_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_states.dart';
import 'package:app/features/profile/presentation/screens/profile_screen.dart';
import 'package:app/main.dart';

import '../../../packages/presentation/view/packages_screen.dart';
import '../../data/model/languages.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final _drawerCubit = serviceLocator.get<DrawerCubit>();

  final _serviceCubit = serviceLocator.get<ServiceCubit>();

  final imagePhoto = sharedPref.getString(CacheConstant.imagePhoto);

  List<Languages> languages = [
    Languages(name: 'English', code: 'en'),
    Languages(name: 'Deutsch', code: 'de'),
    Languages(name: 'العربية', code: 'ar'),
  ];
  Uint8List? bytes;
  final sharedPreferencesUtils = serviceLocator.get<SharedPreferencesUtils>();

  @override
  Widget build(BuildContext context) {
    String? imageFromGallery =
        sharedPreferencesUtils.getString(CacheConstant.imagePhotoFromFile);
    String? imageFromLogin =
        sharedPreferencesUtils.getString(CacheConstant.imagePhoto);
    final email = sharedPreferencesUtils.getString(CacheConstant.emailKey);
    final name = sharedPreferencesUtils.getString(CacheConstant.nameKey);
    final localization = AppLocalizations.of(context)!;

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
                padding: EdgeInsets.only(left: 40.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: Container(
                                    width: 500.w,
                                    height: 500.h,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10, sigmaY: 10),
                                      child: Hero(
                                          tag: 'show_image',
                                          child: imageFromGallery != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          500.r),
                                                  child: Image.file(
                                                    File(imageFromGallery),
                                                    fit: BoxFit.cover,
                                                  ))
                                              : imageFromLogin != null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              500.r),
                                                      child: CashImage(
                                                          path: imageFromLogin),
                                                    )
                                                  : const Icon(Icons.person)),
                                    ),
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
                              tag: 'show_image',
                              child: imageFromGallery != null
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(300.r),
                                      child: Image.file(
                                        File(imageFromGallery),
                                        fit: BoxFit.cover,
                                      ))
                                  : imageFromLogin != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(300.r),
                                          child:
                                              CashImage(path: imageFromLogin))
                                      : Icon(
                                          Icons.person,
                                          size: 150.r,
                                          color: Colors.white,
                                        )),
                        )),
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
                  SizedBox(
                    height: 20.h,
                  ),
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
                  getUserRole() != null
                      ? getUserRole() == 'Client'
                          ? const SizedBox()
                          : InkWell(
                              onTap: () {
                                Scaffold.of(context).closeDrawer();
                                Navigator.of(context)
                                    .pushNamed(PackagesScreen.routeName);
                              },
                              child: ListTile(
                                leading: const Icon(
                                  Icons.all_inbox,
                                  color: ColorManager.primary,
                                ),
                                title: Text(
                                  localization.packages,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontSize: 32.sp),
                                ),
                              ),
                            )
                      : const SizedBox(),
                  getUserRole() != null
                      ? getUserRole() == 'Client'
                          ? const SizedBox()
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
                            .pushReplacementNamed(Routes.loginRoute);
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
