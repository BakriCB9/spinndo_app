import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/service/presentation/screens/service_screen.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../drawer/data/model/languages.dart';
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
      decoration: _drawerCubit.themeMode == ThemeMode.dark
          ? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/images/bg.png"), fit: BoxFit.fill))
          : null,
      child: Scaffold(
        appBar: AppBar(
          actions: [

            isGuest
                ? Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: InkWell(
                      onTap: () {
                        _authCubit.emailController.clear();
                        _authCubit.passwordController.clear();
                        Navigator.of(context).pushNamed(
                          ServiceScreen.routeName,
                        );
                      },
                      child: Text(localization.guest,
                          style: Theme.of(context).textTheme.titleSmall),
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
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(200.r),
                              child: SvgPicture.asset("asset/images/logo.svg"))
                          // Icon(
                          //   Icons.person,
                          //   size: 246.sp,
                          //   color: ColorManager.white,
                          // ),
                          )
                      : const SizedBox(),
                  SizedBox(
                    height: 60.h,
                  ),
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
