import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/const_variable.dart';

import 'show_image.dart';

class RowOfImages extends StatelessWidget {
  File? imagePic;
  List<File>? moreImage;
  int typeSelect;

  RowOfImages(
      {required this.typeSelect,

        this.imagePic,
        this.moreImage,
        super.key});

  ///here i have to take list of images for protofile or diploma
  @override
  Widget build(BuildContext context) {
    return typeSelect == 2
        ? Row(
      children: moreImage!.asMap().entries.map((e) {
        final aux = e;
        return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ShowImage(tag: aux.key, image: e.value.path)));
                },
                child: Hero(
                    tag: e.key,
                    child: Image(
                      image: FileImage(e.value),
                      fit: BoxFit.cover,
                    )),
              ),
            ));
      }).toList(),
    )
        : Container(

      width: 200.w,
      height: 200.h,
      child: Image(image: FileImage(imagePic!), fit: BoxFit.cover),
    );

    // Row(
    //     children: listImage
    //         .map((e) => Expanded(
    //             child: Padding(
    //                 padding: EdgeInsets.symmetric(horizontal: 5.w),
    //                 child: InkWell(
    //                   onTap: () {
    //                     Navigator.of(context).push(MaterialPageRoute(
    //                         builder: (context) => ShowImage(image: e)));
    //                   },
    //                   child: Hero(
    //                       tag: 'aa', child: Image.asset(e, fit: BoxFit.cover)),
    //                 ))))
    //         .toList());
  }
}