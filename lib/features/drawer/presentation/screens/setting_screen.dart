import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/routes/routes.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/widgets/custom_appbar.dart';
import 'package:app/features/drawer/data/model/languages.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_states.dart';
import 'package:app/features/drawer/presentation/screens/change_email_screen.dart';
import 'package:app/features/drawer/presentation/screens/change_password_screen.dart';
import 'package:app/features/service/presentation/cubit/service_setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  static String routeName = '/settingScreen';

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final _drawerCubit = serviceLocator.get<DrawerCubit>();
    final _serviceCubit = serviceLocator.get<ServiceSettingCubit>();
    List<Languages> languages = [
      Languages(name: 'English', code: 'en'),
      Languages(name: 'Deutsch', code: 'de'),
      Languages(name: 'العربية', code: 'ar'),
    ];
    final drawerCubit = serviceLocator.get<DrawerCubit>();

    return Container(
      decoration: drawerCubit.themeMode == ThemeMode.dark
          ? const BoxDecoration(
              color: ColorManager.darkBg,
            )
          : null,

      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbar(appBarText: localization.setting),
              SizedBox(
                height: 50.h,
              ),

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 46.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(localization.themeMood,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w400)),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
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
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(localization.language,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w400))),
                      Expanded(
                        child: SizedBox(
                          width: 90.w,
                          child: Container(
                            decoration: BoxDecoration(
                              color: drawerCubit.themeMode == ThemeMode.dark
                                  ? ColorManager.darkBlue
                                  : ColorManager.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton<Languages>(
                                    icon: const Icon(Icons.language,
                                        color: ColorManager.primary),
                                    value: languages.firstWhere(
                                          (lang) =>
                                      lang.code == _drawerCubit.languageCode,
                                    ),
                                    style:
                                    Theme.of(context).textTheme.displayMedium,
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

                                        _serviceCubit.getCountriesAndCategories();
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(25),
                                    dropdownColor:
                                    _drawerCubit.themeMode == ThemeMode.dark
                                        ? ColorManager.darkBlue
                                        : ColorManager.white)),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ChangeEmailScreen()));
                    },
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        localization.changeEmail,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 30.sp,fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ChangePasswordScreen()));
                    },
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        localization.changePassword,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 30.sp,fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: Theme.of(context).primaryColorDark,
                          context: context,
                          builder: (context) {
                            return SafeArea(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Text(
                                        localization.ourlinks,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(fontSize: 30.sp),
                                      ),
                                      SizedBox(
                                        height: 100.h,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                width: 100.w,
                                                height: 100.h,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                child: const Icon(
                                                  Icons.facebook,
                                                  color: ColorManager.primary,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text(
                                                localization.facebook,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(fontSize: 25.sp),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 30.w,
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                width: 100.w,
                                                height: 100.h,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                child: const Icon(
                                                  Icons.message,
                                                  color: ColorManager.primary,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text(
                                                localization.sms,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(fontSize: 25.sp),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 40.h,
                                      ),
                                    ],
                                  ),
                                ));
                          });
                    },
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      minLeadingWidth: 0,
                      trailing: const Icon(Icons.arrow_forward_ios_rounded,color:ColorManager.grey),
                      title: Text(localization.connectwith,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 30.sp,fontWeight: FontWeight.w400)),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  BlocListener<DrawerCubit, DrawerStates>(
                    bloc: _drawerCubit,
                    listener: (context, state) {
                      if (state is DeleteAccountLoading) {
                        UIUtils.showLoading(context);
                      } else if (state is DeleteAccountError) {
                        UIUtils.hideLoading(context);
                        UIUtils.showMessage(state.message);
                      } else if (state is DeleteAccountSuccess) {
                        UIUtils.hideLoading(context);
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .pushReplacementNamed(Routes.loginRoute);
                      }
                    },
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content:
                                Text(localization.areYouSureToDeleteAccount),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        localization.cancel,
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            color: ColorManager.textColor),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        _drawerCubit.deleteAccount();
                                      },
                                      child: Text(
                                        localization.ok,
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            color: ColorManager.primary),
                                      ))
                                ],
                              );
                            });
                        // _drawerCubit.deleteAccount();
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 0,
                        trailing: const Icon(Icons.arrow_forward_ios_rounded,color:ColorManager.grey,),
                        title: Text(localization.deleteAccount,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 30.sp,fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ),
                ],
              ),
            )
            ],
          ),
        ),
      ),
    );
  }
}
