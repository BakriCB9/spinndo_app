import 'package:app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app/core/di/service_locator.dart';
import 'package:app/core/widgets/loading_indicator.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app/features/profile/presentation/cubit/profile_states.dart';
import 'package:app/features/profile/presentation/widget/client_prfile_screen.dart';
import 'package:app/features/profile/presentation/widget/provider_profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({super.key});
  static const String routeName = '/test';

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  final _profileCubit = serviceLocator.get<ProfileCubit>();
  // final _drawerCubit = serviceLocator.get<DrawerCubit>();

  @override
  void initState() {
    super.initState();
    _profileCubit.getUserRole();
  }

  int typeSelect = 1;

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
        body: BlocBuilder<ProfileCubit, ProfileStates>(buildWhen: (pre, cur) {
          if (cur is GetProfileLoading ||
              cur is GetProfileErrorr ||
              cur is GetProviderSuccess ||
              cur is GetClientSuccess) {
            return true;
          } else {
            return false;
          }
        }, builder: (context, state) {
          if (state is GetProfileLoading) {
            return LoadingIndicator(Theme.of(context).primaryColor);
          } else if (state is GetProfileErrorr) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  SizedBox(height: 20.h),
                  const Icon(
                    Icons.replay_outlined,
                    color: ColorManager.primary,
                  ),
                  TextButton(
                    onPressed: () {
                      _profileCubit.getUserRole();
                    },
                    child: Text(
                      localization.reload,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 30.sp),
                    ),
                  ),

                  SizedBox(height: 30.h),
                ],
              ),
            );
          } else if (state is GetProviderSuccess) {
            return ProviderProfileScreen(providerProfile: state.provider);
          } else if (state is GetClientSuccess) {
            return ClientProfileScreen(clientProfile: state.client);
          } else {
            return SizedBox(
              child: Text(localization.noDataYet),
            );
          }
        }),
      ),
    );
  }
}
