import 'package:app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIconButton extends StatelessWidget {
  final void Function() ontap;
  final IconData? icon;
  final String? svgAssetPath; // بدل SvgPicture جاهز، خليه asset path لمرونة أكثر

  const CustomIconButton({
    super.key,
    required this.ontap,
    this.icon,
    this.svgAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: ontap,
      icon: svgAssetPath != null
          ? SvgPicture.asset(
        svgAssetPath!,
        colorFilter: ColorFilter.mode(
          ColorManager.grey,
          BlendMode.srcIn,
        ),
        width: 20,
        height: 20,
      )
          : Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
