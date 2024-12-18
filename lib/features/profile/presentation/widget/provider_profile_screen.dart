import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/const_variable.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile.dart';
import 'package:app/features/profile/presentation/widget/profile_info/active_day/custom_day_of_active.dart';
import 'package:app/features/profile/presentation/widget/profile_info/job_items/description.dart';
import 'package:app/features/profile/presentation/widget/profile_info/user_account/user_account.dart';
import 'package:app/features/profile/presentation/widget/protofile_and_diploma/custom_diploma_and_protofile.dart';
import 'package:app/features/profile/presentation/widget/sliver_header_widget.dart';

class ProviderProfileScreen extends StatefulWidget {
  final ProviderProfile providerProfile;
  const ProviderProfileScreen({required this.providerProfile, super.key});

  @override
  State<ProviderProfileScreen> createState() => _ProviderProfileScreenState();
}


class _ProviderProfileScreenState extends State<ProviderProfileScreen> {
  final _profileCubit = serviceLocator.get<ProfileCubit>();

  @override
  Widget build(BuildContext context) {
    _profileCubit.latitu=widget.providerProfile.details!.latitude!;
    _profileCubit.longti=widget.providerProfile.details!.longitude!;
    final _drawerCubit = serviceLocator.get<DrawerCubit>();
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: _drawerCubit.themeMode == ThemeMode.dark
          ? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/images/bg.png"), fit: BoxFit.fill))
          : BoxDecoration(
              color: Colors.white.withOpacity(0.1),
            ),
      child: CustomScrollView(
        // controller: _control,
        slivers: [
          SliverPersistentHeader(
            delegate: SliverPersistentDelegate(
                size, widget.providerProfile.imagePath),
            pinned: true,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Switch(
                    activeColor: ColorManager.primary,
                    inactiveTrackColor: ColorManager.white,
                    inactiveThumbColor: Theme.of(context).primaryColor,
                    activeTrackColor: Theme.of(context).primaryColor,
                    value: _drawerCubit.themeMode == ThemeMode.dark,
                    onChanged: (value) {
                      if (value) {
                        _drawerCubit.changeTheme(ThemeMode.dark);
                      } else {
                        _drawerCubit.changeTheme(ThemeMode.light);
                      }
                    },
                  ),
                  SizedBox(height: 15.h),
                  UserAccount(

                    userId: widget.providerProfile.id,
                    typeAccount: 'Provider',
                    isApprovid: widget.providerProfile.details!.isApproved,
                    firstName: widget.providerProfile.firstName!,
                    lastName: widget.providerProfile.lastName!,
                    email: widget.providerProfile.email!,

                  ),
                  SizedBox(height: 15.h),
                  CustomDescription(
                    lat: widget.providerProfile.details!.latitude!,
                    lng: widget.providerProfile.details!.longitude!,
                    cityName: widget.providerProfile.details?.city.toString() ??
                        'Alep',
                    isApprovid: widget.providerProfile.details!.isApproved,
                    userId: widget.providerProfile.id!,
                    categoryName:
                        widget.providerProfile.details?.category?.name ??
                            "No category",
                    description: widget.providerProfile.details?.description ??
                        "No description",
                    serviceName:
                        widget.providerProfile.details?.name ?? "No emial yet",
                  ),
                  SizedBox(height: 10.h),
                  CustomDayActive(
                    userId: widget.providerProfile.id!,
                    issAprrovid: widget.providerProfile.details!.isApproved,
                    listOfworkday: widget.providerProfile.details!.workingDays!,
                  ),
                  SizedBox(height: 30.h),
                  CustomDiplomaAndProtofile(
                    isApprovid: widget.providerProfile.details!.isApproved,
                    userId: widget.providerProfile.id!,
                    imageCertificate:
                        widget.providerProfile.details?.certificatePath ??
                            listImage[0],
                    images: widget.providerProfile.details?.images ?? [],
                  ),
                  SizedBox(height: 100.h)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
