import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/const_variable.dart';

import 'show_image.dart';

class RowOfImages extends StatelessWidget {
  const RowOfImages({super.key});

  ///here i have to take list of images for protofile or diploma
  @override
  Widget build(BuildContext context) {
    return Row(
      children: listImage.asMap().entries.map((e) {
        final aux = e;
        return Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ShowImage(tag: aux.key, image: aux.value)));
            },
            child: Hero(tag: e.key, child: Image.asset(aux.value)),
          ),
        ));
      }).toList(),
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
