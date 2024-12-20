import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/profile/presentation/widget/container_widget.dart';
import 'package:app/features/profile/presentation/widget/icon_button.dart';

import 'position_widget.dart';

class SliverPersistentDelegate extends SliverPersistentHeaderDelegate {
  final Size size;
  final String? image;

  SliverPersistentDelegate(this.size, this.image);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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
                width: isImageBig ? currentImageSize : null,
                image: image),
          ),
          CustomPosition(
              left: 0,
              top: topSpace,
              child: CustomIconButton(
                  ontap: () {
                    Navigator.pop(context);
                  },
                  icon: Icons.arrow_back)),
          CustomPosition(
            top: isImageBig
                ? max(currentPositionforText, topSPaceForImage)
                : initPositionForText * (1 - percent),
            left: isImageBig
                ? max(((size.width / 1.1)) * (1 - percent), minImageSize * 2.2)
                : rightSpace,
            isAnimated: true,
            child: SizedBox(),
          )
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
