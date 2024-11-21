import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:snipp/core/const_variable.dart';
import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/core/widgets/loading_indicator.dart';
import 'package:snipp/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:snipp/features/profile/presentation/cubit/profile_states.dart';
import 'package:snipp/features/profile/presentation/widget/profile_info/active_day/custom_day_of_active.dart';
import 'package:snipp/features/profile/presentation/widget/profile_info/job_items/description.dart';
import 'package:snipp/features/profile/presentation/widget/profile_info/user_account/user_account.dart';
import 'package:snipp/features/profile/presentation/widget/protofile_and_diploma/custom_diploma_and_protofile.dart';
import 'package:snipp/features/profile/presentation/widget/sliver_header_widget.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({super.key});
  static const String routeName = '/test';

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  final _profileCubit = serviceLocator.get<ProfileCubit>();
  final ScrollController _control = ScrollController();
  @override
  void initState() {
    super.initState();
    _profileCubit.getProviderProfile();
  }

  int typeSelect = 1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ProfileCubit, ProfileStates>(builder: (context, state) {
        if (state is GetProfileLoading) {
          return const LoadingIndicator();
        } else if (state is GetProfileError) {
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
                      _profileCubit.getProviderProfile();
                    },
                    child: Text(
                      'Reload',
                      style: TextStyle(fontSize: 25.sp, color: Colors.white),
                    ))
              ],
            ),
          );
        } else if (state is GetProfileSucces) {
          final ans = state.client.details!.workingDays;
          // return Text('successs data');
          final respon = state.client;
          return CustomScrollView(
            controller: _control,
            slivers: [
              SliverPersistentHeader(
                delegate: SliverPersistentDelegate(size),
                pinned: true,
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.h),
                      UserAccount(
                        firstName: state.client.firstName!,
                        lastName: state.client.lastName!,
                        email: state.client.email!,
                      ),
                      SizedBox(height: 15.h),
                      CustomDescription(
                        category:
                            respon.details?.category?.name ?? "No category",
                        description:
                            respon.details?.description ?? "No description",
                        serviceName: respon.details?.name ?? "No emial yet",
                      ),
                      SizedBox(height: 10.h),
                      CustomDayActive(
                        listOfworkday: state.client.details!.workingDays!,
                      ),
                      SizedBox(height: 30.h),
                      CustomDiplomaAndProtofile(
                        imageCertificate:
                            respon.details?.certificatePath ?? listImage[0],
                               images: respon.details?.images??[],
                      ),
                      SizedBox(height: 100.h)
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox(
            child: Text("No data yet"),
          );
        }
      }),
    );
  }
}

// class SliverPersistentDelegate extends SliverPersistentHeaderDelegate {
//   final Size size;

//   SliverPersistentDelegate(this.size);

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     final double maxHeaderHeight = size.height * .3;

//     final double maxImageSize = size.height * 0.22;
//     final double minImageSize = size.height * 0.06;

//     final percent = shrinkOffset / (maxHeaderHeight);
//     final currentImageSize =
//         (maxImageSize * (1 - percent)).clamp(minImageSize, maxImageSize);
//     final currentImagePosition =
//         ((size.width / 2 - minImageSize) * (1 - percent))
//             .clamp(minImageSize, maxImageSize);
//     final double currentPositionforText = (maxHeaderHeight / 2) * (1 - percent);
//     final double initPositionForText = size.height * 0.24;
//     final percent2 = shrinkOffset / maxHeaderHeight;

//     return Container(
//       color: Colors.black,
//       child: Container(
//         color: Theme.of(context)
//             .appBarTheme
//             .backgroundColor!
//             .withOpacity(percent2 * 2 < 1 ? percent2 * 2 : 1),
//         child: Stack(
//           children: [
//             Positioned(
//                 left: currentImageSize < maxHeaderHeight * 0.6
//                     ? currentImagePosition
//                     : null,
//                 top: currentImageSize < maxHeaderHeight * 0.6
//                     ? size.height * 0.04
//                     : null,
//                 bottom: currentImageSize < maxHeaderHeight * 0.6 ? size.height*0.007 : null,
//                 child: Container(
//                   width: currentImageSize < maxHeaderHeight * 0.6
//                       ? currentImageSize
//                       : null,
//                   decoration: BoxDecoration(
//                       shape: currentImageSize < maxHeaderHeight * 0.6
//                           ? BoxShape.circle
//                           : BoxShape.rectangle,
//                       image: const DecorationImage(
//                           image: AssetImage(
//                             'asset/images/messi.jpg',
//                           ),
//                           fit: BoxFit.cover)),
//                 )),
//             Positioned(
//                 left: 0,
//                 top: size.height * 0.04,
//                 child: BackButton(
//                   onPressed: () {},
//                   color: Colors.white,
//                 )),
//             Positioned(
//                 right: size.width*0.03,
//                 top: size.height * 0.04,
//                 child: IconButton(
//                     onPressed: () {},
//                     icon: const Icon(
//                       Icons.edit,
//                       color: Colors.white,
//                     ))),
//             AnimatedPositioned(
//                 duration: const Duration(milliseconds: 200),
//                 top: currentImageSize < maxHeaderHeight * 0.6
//                     ? max(currentPositionforText, size.height * 0.05)
//                     : initPositionForText * (1 - percent),
//                 left: currentImageSize < maxHeaderHeight * 0.6
//                     ? max(((size.width / 1.1)) * (1 - percent),
//                         minImageSize * 2.2)
//                     : size.width*0.03,
//                 bottom: 0,
//                 child: const Text(

//                   'bakri aweja',
//                   style: TextStyle(fontSize: 20, color: Colors.white),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   double get maxExtent => size.height * 0.3;

//   @override
//   double get minExtent => size.height * .11;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     return false;
//   }
// }