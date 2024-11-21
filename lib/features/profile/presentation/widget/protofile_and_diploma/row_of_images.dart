import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/features/profile/data/models/provider_model/image.dart';

import '../../../../../core/widgets/cash_network.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
      children:
      // [Text('No thing yet')]
       
      moreImage!.asMap().entries.map((e) {
        return 
        // Expanded(
        //     child: Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 5.w),
        //       child: InkWell(
        //         onTap: () {
        //           // Navigator.of(context).push(MaterialPageRoute(
        //           //     builder: (context) =>
        //           //         ShowImage(tag: aux.key, image: e.value.path)));
        //         },
        //         child:
        //         Hero(tag: e.key, child: CashImage(path: e.value.path!)),
        //       ),
        //     ));
        CachedNetworkImage(imageUrl: e.value.path!);
      }).toList(),
    )
        :CashImage(path: imagePic!);
  }
}