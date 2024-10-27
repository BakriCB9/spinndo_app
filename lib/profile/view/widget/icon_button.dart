import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final void Function() ontap;
  final IconData icon;
  const CustomIconButton({required this.ontap, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: ontap, icon: Icon(icon,color: Colors.white,));
  }
}
