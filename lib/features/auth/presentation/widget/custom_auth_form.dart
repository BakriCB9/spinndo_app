import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snipp/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:snipp/features/drawer/model/languages.dart';
import 'package:snipp/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:snipp/features/service/presentation/screens/service_screen.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomAuthForm extends StatelessWidget {
  CustomAuthForm(
      {super.key,
      required this.child,
      this.isGuest = true,
      this.hasTitle = true,
      this.hasAvatar = true,
      this.canback = false});

  final bool isGuest;
  final bool hasAvatar;
  final bool canback;
  final bool hasTitle;
  final Widget child;
  final _authCubit = serviceLocator.get<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final _drawerCubit = serviceLocator.get<DrawerCubit>();
    List<Languages> languages = [
      Languages(name: 'English', code: 'en'),
      Languages(name: 'العربية', code: 'ar'),
    ];
    return Container(
       decoration: _drawerCubit.themeMode==ThemeMode.dark?  BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "asset/images/bg.png"),
              fit: BoxFit.fill)):null,
      child: Scaffold(

        appBar: AppBar(
leading: null,
          actions: [IconButton(
            icon: Icon(Icons.arrow_back,size: 1.sp,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

            Expanded(
              child: Transform.scale(scale: 0.8,
                child: Switch(
                  activeColor: ColorManager.primary,
                  inactiveTrackColor: ColorManager.white,
                  inactiveThumbColor: Theme.of(context).primaryColor,
                  activeTrackColor:  Theme.of(context).primaryColor,
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
            ),
            Expanded(
              child: SizedBox(
                width:90.w,
                child: DropdownButtonHideUnderline(
                    child: DropdownButton<Languages>(isExpanded: false,
                        value: languages.firstWhere(
                              (lang) =>
                          lang.code == _drawerCubit.languageCode,
                        ),   dropdownColor:    _drawerCubit.themeMode== ThemeMode.dark
                    ? ColorManager.black
                        : ColorManager.white
                        ,items: languages
                            .map(
                              (language) =>
                              DropdownMenuItem<Languages>(
                                value: language,
                                child: Text(language.name,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontWeight: FontWeight.w500,color:    _drawerCubit.themeMode == ThemeMode.dark
      ? ColorManager.primary
          : ColorManager.black)),
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
                      )),
              ),
            ),
            isGuest
                ? Expanded(
                  child: Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      ServiceScreen.routeName,
                    );
                  },
                  child: Text(localization.guest,
                    style: Theme.of(context).textTheme.titleSmall
                  ),
                              ),
                            ),
                )
                : const SizedBox(),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      canback
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                  onTap: () {
                                    _authCubit.resendCodeTime = 60;
                                    _authCubit.timer?.cancel();

                                    Navigator.of(context).pushReplacementNamed(
                                        SignUpScreen.routeName);
                                  },
                                  child: Icon(Icons.arrow_back)),
                            )
                          : SizedBox(),

                    ],
                  ),
                  hasAvatar
                      ? CircleAvatar(
                          radius: 170.r,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: ClipRRect(borderRadius: BorderRadius.circular(200.r),child: SvgPicture.asset("asset/images/logo.svg"))
                          // Icon(
                          //   Icons.person,
                          //   size: 246.sp,
                          //   color: ColorManager.white,
                          // ),
                        )
                      : const SizedBox(),
SizedBox(height: 60.h,),
                  child
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
