import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/routes/routes.dart';
import 'package:app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/service/presentation/screens/service_screen.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/resources/color_manager.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<Offset> _logoSlideAnimation;
  late Animation<double> _logoRotationAnimation;

  final _authCubit = serviceLocator.get<AuthCubit>();

  late AnimationController _textController;
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();

    // Logo Animations (slide + rotate)
    _logoController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _logoSlideAnimation = Tween<Offset>(
      begin: const Offset(-0.05, 0),
      end: const Offset(0.05, 0),
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeInOutSine,
      ),
    );

    _logoRotationAnimation = Tween<double>(
      begin: -0.05,
      end: 0.05,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeInOut,
      ),
    );

    _logoController.repeat(reverse: true);

    // Text Animation
    _textController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _textFadeAnimation = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Curves.easeOut,
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {
      _textController.forward();
    });

    Future.delayed(const Duration(seconds: 4), () async {
      if (sharedPref.getString(CacheConstant.tokenKey) == null) {
        Navigator.of(context).pushNamedAndRemoveUntil(Routes.loginRoute, (p){
          return p.settings.name == Routes.loginRoute;

        });
        print('the current size is nowwwwwwwwwwwwwwwwwwwwwwwwwwwww ${navObserver.stackSize}');
        navObserver.printRouts();
      } else {
        return Navigator.of(context).pushNamedAndRemoveUntil(ServiceScreen.routeName,(p){return false;});
      }
    });
  }
  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final drawerCubit = serviceLocator.get<DrawerCubit>();
    final isDarkMode = drawerCubit.themeMode == ThemeMode.dark;

    return Container(
      decoration: isDarkMode
          ? const BoxDecoration(
       color: ColorManager.darkBg
      )
          : null,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDarkMode
                  ? [Colors.transparent, Colors.transparent]
                  : [Colors.white, Colors.grey.shade200],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),
                // Logo with only slide + rotate
                SlideTransition(
                  position: _logoSlideAnimation,
                  child: RotationTransition(
                    turns: _logoRotationAnimation,
                    child: CircleAvatar(
                      radius: 200.r,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: SvgPicture.asset(
                          'asset/images/logo.svg',
                          height: 400.h,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                // Text
                SlideTransition(
                  position: _textSlideAnimation,
                  child: FadeTransition(
                    opacity: _textFadeAnimation,
                    child: Text(
                      'SPINNDO',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                        fontSize: 52.sp,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 8,
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
