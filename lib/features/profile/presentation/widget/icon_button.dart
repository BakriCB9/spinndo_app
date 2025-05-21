import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final void Function() ontap;
  final Widget icon;
  const CustomIconButton({required this.ontap, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: ontap,
      icon: icon,
    );
  }
}
