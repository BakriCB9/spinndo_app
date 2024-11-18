// import 'package:clean/core/resources/strings_manager.dart';
// import 'package:flutter/material.dart';
//
// class Routes {
//   static const String splashRoute = '/';
//
//   static const String serialNumberRoute = '/Login';
//
//   static const String homeRoute = '/Home';
//
//   static const String healersListRoute = '/Healers-List';
//   static const String healerProfileRoute = '/Healer-Profile';
//   static const String healerAppointmentsRoute = '/Healer-Appointments';
//
//   static const String proUsersLatestListRoute = '/Pro-Users-Latest-List';
//   static const String proUserProfileRoute = '/Pro-User-Profile';
//
//   static const String freeUsersLatestListRoute = '/Free-Users-Latest-List';
//   static const String freeUserProfileRoute = '/Free-User-Profile';
//
//   static const String sessionsListRoute = '/Sessions-List';
//   static const String sessionDetailsRoute = '/Session-Details';
//   static const String sessionEditRoute = '/Session-Edit';
//
//   static const String sessionsDashboardRoute = '/Sessions-Dashboard';
//   static const String termsConditionsRoute = '/Terms-Conditions';
//   static const String termsConditionsHistoryRoute = '/Terms-Conditions-History';
//   static const String proDashboardRoute = '/Pro-Dashboard';
//   static const String freeDashboardRoute = '/Free-Dashboard';
//   static const String reviewDashboardRoute = '/Review-Dashboard';
//   static const String reviewListRoute = '/Review-List';
//   static const String dailyMsgDashboardRoute = '/Daily-Msg-Dashboard';
//   static const String blogDashboardRoute = '/Blog-Dashboard';
//   static const String postDetailsRoute = '/Post-Details';
//   static const String addPostRoute = '/Add-Post';
//   static const String editPostRoute = '/Edit-Post';
//   static const String profitRoute = '/Profit';
//   static const String audiosRoute = '/Audios';
//   static const String addAudioRoute = '/Add-Audio';
//   static const String editAudioRoute = '/Edit-Audio';
//   static const String activityRoute = '/Activity';
//
//   static const String addSessionRoute = '/Add-Session';
//   static const String uploadSessionRoute = '/Upload-Session';
//   static const String proBoardListRoute = '/Pro-Board-List';
//   static const String viewAllSessionsRoute = '/View-All-Sessions';
//   static const String appointmentsRoute = '/Appointments';
//   static const String addAppointmentsRoute = '/Add-Appointments';
// }
//
// class RouteGenerator {
//   static Route<dynamic> getRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case Routes.splashRoute:
//         return MaterialPageRoute(builder: (_) => const SplashWidget());
//       default:
//         return unDefinedRoute();
//     }
//   }
//
//   static Route<dynamic> unDefinedRoute() {
//     return MaterialPageRoute(
//       builder: (_) => Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text(
//             AppStrings.noRouteFound,
//           ),
//         ),
//         body: const Center(
//           child: Text(
//             AppStrings.noRouteFound,
//           ),
//         ),
//       ),
//     );
//   }
// }
