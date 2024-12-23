import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:app/features/drawer/data/model/languages.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});
  static String routeName = '/settingScreen';
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _drawerCubit = serviceLocator.get<DrawerCubit>();
  List<Languages> languages = [
    Languages(name: 'English', code: 'en'),
    Languages(name: 'العربية', code: 'ar'),
  ];
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Container(
        decoration: _drawerCubit.themeMode == ThemeMode.dark
        ? const BoxDecoration(
        image: DecorationImage(
        image: AssetImage("asset/images/bg.png"), fit: BoxFit.fill))
        : null,
    child: Scaffold(
    appBar: AppBar(
    title: Text(localization.setting),
    ),
    body: Padding(
    padding: EdgeInsets.symmetric(horizontal: 30.w),
    child: Column(
    children: [
    SizedBox(
    height: 50.h,
    ),
    Row(
    children: [
    Expanded(
    flex: 3,
    child: Text(localization.themeMood,
    style: Theme.of(context)
        .textTheme
        .titleLarge!
        .copyWith(fontSize: 30.sp)),
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
    child: Text(localization.language,
    style: Theme.of(context)
        .textTheme
        .titleLarge!
        .copyWith(fontSize: 30.sp))),
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
    border:
    Border.all(color: Colors.grey)),
    child: Icon(
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
          border: Border.all(color: Colors.grey)),
      child: Icon(
        Icons.message,
        color: ColorManager.primary,
      ),
    ),
      SizedBox(height: 10.h,),
      Text(localization.sms,style: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(fontSize: 25.sp),)
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
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        title: Text(localization.connectwith,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 30.sp)),
      ),
    ),
      SizedBox(
        height: 60.h,
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
                .pushReplacementNamed(SignInScreen.routeName);
          }
        },
        child: InkWell(
          onTap: () {
            _drawerCubit.deleteAccount();
          },
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            minLeadingWidth: 0,
            trailing:const  Icon(Icons.arrow_forward_ios_rounded),
            title: Text(localization.deleteAccount,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 30.sp)),
          ),
        ),
      ),
    ],
    ),
    ),
    ),
    );
  }
}