import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:snipp/features/profile/data/models/provider_model/image.dart';

import 'show_image.dart';

class RowOfImages extends StatelessWidget {
  String? imagePic;
  List<ImagesPath>? moreImage;
  int typeSelect;

  RowOfImages(
      {required this.typeSelect, this.imagePic, this.moreImage, super.key});

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
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) =>
                    //         ShowImage(tag: aux.key, image: e.value.path)));
                  },
                  child: Hero(
                      tag: e.key,
                      child: Image(
                        image: NetworkImage(aux.value.path!),
                        fit: BoxFit.cover,
                      )),
                ),
              ));
            }).toList(),
          )
        : Container(
            width: 200.w,
            height: 200.h,
            child: Image(image: NetworkImage(imagePic!), fit: BoxFit.cover),
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
