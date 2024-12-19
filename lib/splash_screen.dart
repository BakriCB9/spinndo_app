//
// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:app/core/di/service_locator.dart';
// import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
// import 'package:app/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
//
// class SplashScren extends StatefulWidget {
//   static const String routeName = '/splash';
//
//   const SplashScren({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScren> createState() => _SplashScrenState();
// }
//
// class _SplashScrenState extends State<SplashScren> with TickerProviderStateMixin {
//   late AnimationController _fadeController;
//   late AnimationController _slideController;
//   late Animation<Offset> _slideAnimation;
//   late double _logoOpacity;
//   @override
//
//   void initState() {
//     super.initState();
//
//     // Initialize logo fade animation
//     _logoOpacity = 0.0;
//
//     // Fade-in animation for logo
//     Future.delayed(Duration(milliseconds: 500), () {
//       setState(() {
//         _logoOpacity = 1.0;
//       });
//     });
//
//     // Initialize slide-in animation for text
//     _slideController = AnimationController(
//       duration: Duration(milliseconds: 1000),
//       vsync: this,
//     );
//
//     _slideAnimation = Tween<Offset>(
//       begin: Offset(-1.5, 0), // Starts from off the screen to the left
//       end: Offset(0, 0),      // Ends at its final position
//     ).animate(CurvedAnimation(
//       parent: _slideController,
//       curve: Curves.easeOut,
//     ));
//
//     // Start slide animation after logo is fully faded in
//     Future.delayed(Duration(seconds: 1), () {
//       _slideController.forward();
//     });
//
//     // Navigate to the next screen after the animation
//     Future.delayed(Duration(seconds: 4), () {
//       Navigator.pushReplacementNamed(context, '/home'); // Replace '/home' with your desired route
//     });
//   }
//   @override
//   void dispose() {
//     _slideController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {    final _drawerCubit = serviceLocator.get<DrawerCubit>();
//
//   return Container(
//     decoration: _drawerCubit.themeMode == ThemeMode.dark
//         ? BoxDecoration(
//         image: DecorationImage(
//             image: AssetImage("asset/images/bg.png"), fit: BoxFit.fill))
//         : null,
//     child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//           body: Container(
//             child: Center(
//               child: ListView(
//                 children: [
//                   SizedBox(
//                     height: 500,
//                     width: 500,
//                     child: AnimatedSplashScreen(backgroundColor: Colors.transparent,
//                         centered: true,
//                         splashTransition: SplashTransition.fadeTransition,
//                         // pageTransitionType: PageTransitionType.bottomToTop,
//                         splash:   CircleAvatar(radius: 85,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(150),
//                             child: SvgPicture.asset(
//                               'asset/images/logo.svg',
//
//                               height: 170,
//                                                 ),
//                           ),
//                         ),
//                         splashIconSize: 250,
//                         nextScreen: MyApp(),
//                         duration: 4000),
//                   ),
//                   Center(
//                     child: SlideTransition(
//                         position: _slideAnimation,
//                         child:  Text('Spinndo',style: TextStyle(
//                             color:_drawerCubit.themeMode==ThemeMode.dark? Colors.white70:Colors.black,
//                             fontSize: 32.0,
//                             fontWeight: FontWeight.bold),)
//                         )
//                   ),
//
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//   );
//   }
// }
