import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:snipp/core/const_variable.dart';
import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/core/widgets/loading_indicator.dart';
import 'package:snipp/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:snipp/features/profile/presentation/cubit/profile_states.dart';
import 'package:snipp/features/profile/presentation/widget/client_prfile_screen.dart';
import 'package:snipp/features/profile/presentation/widget/profile_info/active_day/custom_day_of_active.dart';
import 'package:snipp/features/profile/presentation/widget/profile_info/job_items/description.dart';
import 'package:snipp/features/profile/presentation/widget/profile_info/user_account/user_account.dart';
import 'package:snipp/features/profile/presentation/widget/protofile_and_diploma/custom_diploma_and_protofile.dart';
import 'package:snipp/features/profile/presentation/widget/provider_profile_screen.dart';
import 'package:snipp/features/profile/presentation/widget/sliver_header_widget.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({super.key});
  static const String routeName = '/test';

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  final _profileCubit = serviceLocator.get<ProfileCubit>();

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
          return const LoadingIndicator();
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
                        backgroundColor: WidgetStatePropertyAll(Colors.blue)),
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
         return  ProviderProfileScreen(providerProfile: state.provider);
          // final ans = state.provider.details!.workingDays;
          // // return Text('successs data');
          // final respon = state.provider;
          // return CustomScrollView(
          //   controller: _control,
          //   slivers: [
          //     SliverPersistentHeader(
          //       delegate: SliverPersistentDelegate(size),
          //       pinned: true,
          //     ),
          //     SliverFillRemaining(
          //       hasScrollBody: false,
          //       child: Padding(
          //         padding:
          //             EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             SizedBox(height: 15.h),
          //             UserAccount(
          //               firstName: state.provider.firstName!,
          //               lastName: state.provider.lastName!,
          //               email: state.provider.email!,
          //             ),
          //             SizedBox(height: 15.h),
          //             CustomDescription(
          //               category:
          //                   respon.details?.category?.name ?? "No category",
          //               description:
          //                   respon.details?.description ?? "No description",
          //               serviceName: respon.details?.name ?? "No emial yet",
          //             ),
          //             SizedBox(height: 10.h),
          //             CustomDayActive(
          //               listOfworkday: state.provider.details!.workingDays!,
          //             ),
          //             SizedBox(height: 30.h),
          //             CustomDiplomaAndProtofile(
          //               imageCertificate:
          //                   respon.details?.certificatePath ?? listImage[0],
          //                      images: respon.details?.images??[],
          //             ),
          //             SizedBox(height: 100.h)
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // );
        }else if(state is GetClientSuccess){
          return ClientProfileScreen(clientProfile: state.client);
        }

        else {
          return const SizedBox(
            child: Text("No data yet"),
          );
        }
      }),
    );
  }
}