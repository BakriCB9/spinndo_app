import 'package:app/core/di/service_locator.dart';
import 'package:app/core/routes/animation_route.dart';
import 'package:app/core/routes/routes.dart';
import 'package:app/features/auth/presentation/cubit/cubit/login_cubit.dart';
import 'package:app/features/auth/presentation/cubit/cubit/register_cubit.dart';
import 'package:app/features/auth/presentation/cubit/cubit/verification_cubit.dart';
import 'package:app/features/auth/presentation/screens/employee_details.dart';
import 'package:app/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:app/features/auth/presentation/screens/verfication_code_screen.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/google_map/presentation/view/google_map_screen.dart';
import 'package:app/features/google_map/presentation/view_model/cubit/google_map_cubit.dart';
import 'package:app/features/service/presentation/cubit/service_setting_cubit.dart';
import 'package:app/features/service/presentation/screens/filter_result_screen.dart';
import 'package:app/features/service/presentation/screens/get_main_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoutesGenerator {
  static Route<dynamic>? getRoute(RouteSettings settings) {
    final drawerCubit = serviceLocator.get<DrawerCubit>();
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.loginRoute:
        // return MaterialPageRoute(builder: (_) => SignInScreen());
        return AnimationRoute(page: SignInScreen());
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: args as LoginCubit,
                  child: ForgotPasswordScreen(),
                ));

      case Routes.registerRoute:
        return AnimationRoute(page: SignUpScreen());

      case Routes.employeDetails:
        return AnimationRoute(
            page: BlocProvider.value(
                value: args as RegisterCubit, child: EmployeeDetails()));
      case Routes.verificationRoutes:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (_) => serviceLocator.get<VerificationCubit>(),
                child: VerficationCodeScreen(
                  email: args as String,
                )));

      case Routes.googleMapSccren:
        return MaterialPageRoute(builder: (_) {
          final data = args as Map<String, dynamic>;
          return GoogleMapScreen(
            nameOfCountry: data['countryName'],
            currentLocation: data['latlng'],
            mapType: data['type'],
          );
        });
      case Routes.serviceFilterScreen:
        return AnimationRoute(
            page: BlocProvider.value(
          value: args as ServiceSettingCubit,
          child: FilterResultScreen(),
        ));

      case Routes.getMainCategoryScreen:
        return MaterialPageRoute(builder: (_) => const GetMainCategoryScreen());
      default:
        return _undefinedRoute();
    }
  }

  static Route<dynamic> _undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found')),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}
