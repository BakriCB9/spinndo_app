import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app/features/profile/presentation/widget/section_body_of_bottom_sheet.dart';
import 'package:app/features/profile/presentation/widget/section_image.dart';
import 'package:flutter/material.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';

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

    // final _sharedPreferencesUtils =
    //     serviceLocator.get<SharedPreferencesUtils>();

    // final double maxHeaderHeight = size.height * .3;

    // final double maxImageSize = size.height * 0.22;
    // final double minImageSize = size.height * 0.06;

    // final percent = shrinkOffset / (maxHeaderHeight);
    // final currentImageSize =
    //     (maxImageSize * (1 - percent)).clamp(minImageSize, maxImageSize);
    // final currentImagePosition =
    //     ((size.width / 2 - minImageSize) * (1 - percent))
    //         .clamp(minImageSize, maxImageSize);
    // final double currentPositionforText = (maxHeaderHeight / 2) * (1 - percent);
    // final double initPositionForText = size.height * 0.24;

    // final bool isImageBig = currentImageSize < maxHeaderHeight * .6;
    // final double topSpace = size.height * 0.04;
    // final double topSPaceForImage = size.height * 0.05;
    // final double bottomSpaceForImage = size.height * 0.007;
    //final double rightSpace = size.width * 0.03;
    final drawerCubit = serviceLocator.get<DrawerCubit>();

    return Container(
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
                  Container(
                    decoration: const BoxDecoration(
                        color: ColorManager.white, shape: BoxShape.circle),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  myId == userId
                      ? Container(
                          decoration: const BoxDecoration(
                              color: ColorManager.white,
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
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ],
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