import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/widgets/loading_indicator.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app/features/profile/presentation/cubit/profile_states.dart';
import 'package:app/features/profile/presentation/widget/client_prfile_screen.dart';
import 'package:app/features/profile/presentation/widget/provider_profile_screen.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({super.key});
  static const String routeName = '/test';

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  final _profileCubit = serviceLocator.get<ProfileCubit>();
  final _drawerCubit = serviceLocator.get<DrawerCubit>();

  @override
  void initState() {
    super.initState();
    _profileCubit.getUserRole();
  }

  int typeSelect = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ProfileCubit, ProfileStates>(builder: (context, state) {
        if (state is GetProfileLoading) {
          return LoadingIndicator(Theme.of(context).primaryColor);
        } else if (state is GetProfileErrorr) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  state.message,
                  style: TextStyle(
                      fontSize: 30.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20.h),
                Lottie.asset('asset/animation/error.json'),
                SizedBox(
                  height: 30.h,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).primaryColor,
                    )),
                    onPressed: () {
                      _profileCubit.getUserRole();
                    },
                    child: Text(
                      'Reload',
                      style: TextStyle(fontSize: 25.sp, color: Colors.white),
                    ))
              ],
            ),
          );
        } else if (state is GetProviderSuccess) {
          return ProviderProfileScreen(providerProfile: state.provider);

        } else if (state is GetClientSuccess) {
          return ClientProfileScreen(clientProfile: state.client);
        } else {
          return const SizedBox(
            child: Text("No data yet"),
          );
        }
      }),
    );
  }
}
