import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';

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

    return Container(
      decoration: _drawerCubit.themeMode == ThemeMode.dark
          ? const BoxDecoration(
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  'asset/icons/back.svg',
                                  width: 20,
                                  height: 20,
                                  colorFilter: const ColorFilter.mode(
                                    Color(0xFF9E9E9E),
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),)
                          : const SizedBox(),
                      const Spacer(),
                      // isGuest
                      //     ? InkWell(
                      //         onTap: () {
                      //           // _authCubit.emailController.clear();
                      //           // _authCubit.passwordController.clear();
                      //           // _authCubit.firstNameContoller.clear();
                      //           // _authCubit.lastNameContoller.clear();
                      //           // _authCubit.passwordController.clear();
                      //           // _authCubit.confirmPasswordController.clear();

                      //           // Navigator.of(context).pushNamedAndRemoveUntil(
                      //           //     ServiceScreen.routeName, (p) {

                      //           //   return p.settings.name !=
                      //           //       ServiceScreen.routeName||p.settings.name!=SignInScreen.routeName;
                      //           // });
                      // Navigator.of(context).pushNamedAndRemoveUntil(ServiceScreen.routeName, (p)=>false);

                      // Navigator.of(context).pushReplacementNamed(
                      //   ServiceScreen.routeName,
                      // );
                      //   navObserver.printRouts();
                      //   print(
                      //       'the current size is SignIn Scrfeeeeeeeeeeeeeeeeeeeeeeen ${navObserver.stackSize}');
                      // },
                      //     child: Text(localization.guest,
                      //         style:
                      //             Theme.of(context).textTheme.titleSmall),
                      //   )
                      // : const SizedBox(),
                    ],
                  ),
                  SizedBox(height: 80.h),
                  hasAvatar
                      ? CircleAvatar(
                          radius: 170.r,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(200.r),
                              child: SvgPicture.asset("asset/images/logo.svg")))
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
