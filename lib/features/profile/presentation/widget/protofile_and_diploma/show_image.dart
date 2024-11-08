import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowImage extends StatelessWidget {
  final String image;
  final int tag;
  const ShowImage({required this.tag, required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Hero(
            tag: tag,
            child: InteractiveViewer(
              clipBehavior: Clip.none,
              maxScale: 3,
              minScale: 0.5,
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset(image, fit: BoxFit.cover),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
