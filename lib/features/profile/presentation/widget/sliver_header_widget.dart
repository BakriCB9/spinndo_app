import 'package:app/core/utils/image_functions.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app/features/profile/presentation/cubit/profile_states.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/profile/presentation/widget/container_widget.dart';
import 'package:app/features/profile/presentation/widget/icon_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'position_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SliverPersistentDelegate extends SliverPersistentHeaderDelegate {
  final Size size;
  final String? image;

  SliverPersistentDelegate(this.size, this.image);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final _profileCubit = serviceLocator.get<ProfileCubit>();
    final localization = AppLocalizations.of(context)!;

    final double maxHeaderHeight = size.height * .3;

    final double maxImageSize = size.height * 0.22;
    final double minImageSize = size.height * 0.06;

    final percent = shrinkOffset / (maxHeaderHeight);
    final currentImageSize =
    (maxImageSize * (1 - percent)).clamp(minImageSize, maxImageSize);
    final currentImagePosition =
    ((size.width / 2 - minImageSize) * (1 - percent))
        .clamp(minImageSize, maxImageSize);
    final double currentPositionforText = (maxHeaderHeight / 2) * (1 - percent);
    final double initPositionForText = size.height * 0.24;

    final bool isImageBig = currentImageSize < maxHeaderHeight * .6;
    final double topSpace = size.height * 0.04;
    final double topSPaceForImage = size.height * 0.05;
    final double bottomSpaceForImage = size.height * 0.007;
    final _drawerCubit = serviceLocator.get<DrawerCubit>();
    final double rightSpace = size.width * 0.03;
    return Container(
      color: _drawerCubit.themeMode == ThemeMode.dark
          ? Theme.of(context).primaryColorDark
          : ColorManager.primary,
      // color: Theme.of(context)
      //     .appBarTheme
      //     .
      //     .withOpacity(percent * 2 < 1 ? percent * 2 : 1),
      child: Stack(
        children: [
          CustomPosition(
              bottom: isImageBig ? bottomSpaceForImage : null,
              top: isImageBig ? topSpace : null,
              left: isImageBig ? currentImagePosition : null,
              child: CustomContainer(
                  shape: isImageBig ? BoxShape.circle : BoxShape.rectangle,
                  width: isImageBig ? currentImageSize : double.infinity,
                  initialImage: image)),
          CustomPosition(
              left: 0,
              top: topSpace,
              child: CustomIconButton(
                  ontap: () {
                    Navigator.pop(context);
                  },
                  icon: Icons.arrow_back)),
          CustomPosition(
              right: 0,
              top: topSpace,
              child: CustomIconButton(
                  ontap: () {
                    showModalBottomSheet(
                        backgroundColor: Theme.of(context).primaryColorDark,
                        context: context,
                        builder: (context) {
                          return SafeArea(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30.w),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Text(localization.profilePhoto),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                Navigator.of(context).pop();
                                                final image = await ImageFunctions
                                                    .CameraPicker(true);
                                                if (image == null) {
                                                  return;
                                                }
                                                _profileCubit.addImagePhoto(image);
                                              },
                                              child: Container(
                                                width: 100.w,
                                                height: 100.h,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  color: ColorManager.primary,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 15.h),
                                            Text(
                                              'Camera',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(fontSize: 25.sp),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 35.w,
                                        ),
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                Navigator.of(context).pop();
                                                final image = await ImageFunctions
                                                    .galleryPicker(true);
                                                if (image == null) {
                                                  return;
                                                }
                                                _profileCubit.addImagePhoto(image);
                                              },
                                              child: Container(
                                                width: 100.w,
                                                height: 100.h,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                child: Icon(
                                                  Icons.image_outlined,
                                                  color: ColorManager.primary,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 15.h),
                                            Text(
                                              'Gallery',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(fontSize: 25.sp),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 50.h,
                                    )
                                  ],
                                ),
                              ));
                        });
                  },
                  icon: Icons.camera_alt_outlined)),
          // CustomPosition(child: IconButton(onPressed: (){}, icon:Icon(Icons.camera_alt_outlined,color: ColorManager.primary,))),
          // CustomPosition(
          //   top: isImageBig
          //       ? max(currentPositionforText, topSPaceForImage)
          //       : initPositionForText * (1 - percent),
          //   left: isImageBig
          //       ? max(((size.width / 1.1)) * (1 - percent), minImageSize * 8.5)
          //       : rightSpace,
          //   isAnimated: true,
          //   child: Icon(Icons.camera_alt_outlined,color: Colors.white,)
          // )
        ],
      ),
    );
  }

  @override
  double get maxExtent => size.height * 0.3;

  @override
  double get minExtent => size.height * .11;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
