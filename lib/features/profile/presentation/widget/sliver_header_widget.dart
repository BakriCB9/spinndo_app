import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app/features/profile/presentation/widget/section_body_of_bottom_sheet.dart';
import 'package:app/features/profile/presentation/widget/section_image.dart';
import 'package:flutter/material.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliverPersistentDelegate extends SliverPersistentHeaderDelegate {
  final Size size;
  final String? image;
  final int userId;
  final int myId;

  const SliverPersistentDelegate(
      {required this.userId,
      required this.size,
      required this.image,
      required this.myId});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final _profileCubit = serviceLocator.get<ProfileCubit>();
    final drawerCubit = serviceLocator.get<DrawerCubit>();

    return Scaffold(
      body: Container(
        color: drawerCubit.themeMode == ThemeMode.dark
            ? Theme.of(context).primaryColorDark
            : ColorManager.primary,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const SectionImage(),
            Positioned(
              child: SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(30.w),
                      child: Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(Icons.arrow_back_ios_rounded,color: ColorManager.textColor,),
                        ),
                      ),
                    ),
                    myId == userId
                        ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: ColorManager.white2,
                                  shape: BoxShape.circle),
                              child: IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        backgroundColor:
                                            Theme.of(context).primaryColorDark,
                                        context: context,
                                        builder: (context) {
                                          return SectionBodyOfBottomSheet(
                                              profileCubit: _profileCubit);
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                  )),
                            ),
                        )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => size.height * 0.4;

  @override
  double get minExtent => size.height * .12;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}


 // BlocBuilder<ProfileCubit,
                                                //         ProfileStates>(
                                                //     builder: (context, state) {
                                                //   return (imagePhotoGallery !=
                                                //               null) ||
                                                //           (imagePhotoLogin !=
                                                //               null)
                                                //       ? IconButton(
                                                //           icon: const Icon(
                                                //               Icons.delete),
                                                //           onPressed: () {
                                                //             Navigator.of(
                                                //                     context)
                                                //                 .pop();
                                                //             _profileCubit
                                                //                 .deleteImage();
                                                //           },
                                                //         )
                                                //       : const SizedBox();
                                                //   //    : const SizedBox();
                                                // })