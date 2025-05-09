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

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoScaleAnimation;
  final _authCubit = serviceLocator.get<AuthCubit>();
  late AnimationController _textController;
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();

    // Logo Animation (Fade + Scale)
    _logoController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _logoFadeAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeIn,
    );
    _logoScaleAnimation =
        Tween<double>(begin: 0.6, end: 1.0).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOutBack,
    ));

    // Text Animation (Fade + Slide)
    _textController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _textFadeAnimation = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );
    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5), // Start below the center
      end: Offset.zero, // End at original position
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    ));

    // Start Animations
    _logoController.forward();
    Future.delayed(const Duration(seconds: 1), () {
      _textController.forward();
    });

    // Navigate to the next screen
    Future.delayed(const Duration(seconds: 4), () async {
      //await _authCubit.getCategories();
  // Navigator.of(context).pushNamedAndRemoveUntil(SignInScreen.routeName, (p){
  //   return p.settings.name == SignInScreen.routeName;
  // });
      if (sharedPref.getString(CacheConstant.tokenKey) == null) {
        Navigator.of(context).pushNamedAndRemoveUntil(Routes.loginRoute, (p){
    return p.settings.name == Routes.loginRoute;
  
  });
  print('the current size is nowwwwwwwwwwwwwwwwwwwwwwwwwwwww ${navObserver.stackSize}');
  navObserver.printRouts();
        // return Navigator.of(context)
        //     .pushReplacementNamed(SignInScreen.routeName);
      } else {
        return Navigator.of(context)
            .pushReplacementNamed(ServiceScreen.routeName);
      }
      // Navigator.pushReplacementNamed(
      //   context,
      //   sharedPref.getString(CacheConstant.tokenKey) == null
      //       ? (sharedPref.getString(CacheConstant.emailKey) == null
      //           ? SignUpScreen.routeName
      //           : SignInScreen.routeName)
      //       : ServiceScreen.routeName,
      // );
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
          ? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/images/bg.png"), fit: BoxFit.fill))
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
                Spacer(flex: 3),
                // Logo with fade + scale animation
                ScaleTransition(
                  scale: _logoScaleAnimation,
                  child: FadeTransition(
                    opacity: _logoFadeAnimation,
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
                Spacer(),
                // Text with fade + slide animation
                SlideTransition(
                  position: _textSlideAnimation,
                  child: FadeTransition(
                    opacity: _textFadeAnimation,
                    child: Text(
                      'SPINNDO',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                        fontSize: 52.sp,
                        fontFamily: 'Raleway', // Elegant font
                        fontWeight: FontWeight.bold,
                        letterSpacing: 8,
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 6,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
