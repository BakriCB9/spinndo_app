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
  CustomAuthForm({
    super.key,
    required this.child,
    this.isGuest = false,
    this.hasTitle = true,
    this.hasAvatar = true,
    this.canBack = true,
  });

  final bool isGuest;
  final bool hasAvatar;
  final bool hasTitle;
  final Widget child;
  final bool canBack;
  final _authCubit = serviceLocator.get<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final _drawerCubit = serviceLocator.get<DrawerCubit>();
    List<Languages> languages = [
      Languages(name: 'English', code: 'en'),
      Languages(name: 'Deutsch', code: 'de'),
      Languages(name: 'العربية', code: 'ar'),
    ];
    return Container(
      decoration: _drawerCubit.themeMode == ThemeMode.dark
          ? BoxDecoration(
          image: DecorationImage(
              image: AssetImage("asset/images/bg.png"), fit: BoxFit.fill))
          : null,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      canBack
                          ? InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back_sharp,
                            color: Theme.of(context).primaryColorLight,
                            size: 45.sp,
                          ))
                          : const SizedBox(),
                      Spacer(),
                      isGuest
                          ? InkWell(
                        onTap: () {
                          _authCubit.emailController.clear();
                          _authCubit.passwordController.clear();
                          _authCubit.firstNameContoller.clear();
                          _authCubit.lastNameContoller.clear();
                          _authCubit.passwordController.clear();
                          _authCubit.confirmPasswordController.clear();

                          Navigator.of(context).pushNamed(
                            ServiceScreen.routeName,
                          );
                        },
                        child: Text(localization.guest,
                            style:
                            Theme.of(context).textTheme.titleSmall),
                      )
                          : const SizedBox(),
                    ],
                  ),
                  SizedBox(
                    height: 80.h,
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
