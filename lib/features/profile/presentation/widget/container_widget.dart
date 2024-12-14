import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String? image;
  final double? width;
  final BoxShape shape;
  const CustomContainer(
      {required this.shape, this.width, required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: image == null
                    ? AssetImage('asset/images/aaaa.png')
                    : NetworkImage(image!),
                fit: BoxFit.cover),
            shape: shape),
        child: null);
  }
}
