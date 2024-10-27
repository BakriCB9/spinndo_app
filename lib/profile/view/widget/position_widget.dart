import 'package:flutter/material.dart';

class CustomPosition extends StatelessWidget {
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final Widget child;
  final bool? isAnimated;
  const CustomPosition(
      {this.bottom,
      this.left,
      this.right,
      this.top,
      this.isAnimated,
      required this.child,
      super.key});

  @override
  Widget build(BuildContext context) {
    return isAnimated != null
        ? AnimatedPositioned(
            top: top,
            left: left,
            bottom: bottom,
            right: right,
            duration: const Duration(milliseconds: 150),
            child: child)
        : Positioned(
            top: top,
            left: left,
            bottom: bottom,
            right: right,
            child: child,
          );
  }
}
