import 'package:app/core/constant.dart';
import 'package:app/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile_image.dart';

import '../../../../../core/widgets/cash_network.dart';

class RowOfImages extends StatelessWidget {
  String? imagePic;
  List<ProviderProfileImage>? moreImage;
  int typeSelect;
  int userId;

  RowOfImages(
      {
        required this.userId,
        required this.typeSelect, this.imagePic, this.moreImage, super.key});

  ///here i have to take list of images for protofile or diploma
  final myId = sharedPref.getInt(CacheConstant.userId);
  @override
  Widget build(BuildContext context) {
     // myId != userId?typeSelect=2:typeSelect;
    if(myId!=userId){
      typeSelect=2;
    }
    print(
        'the image is of provider is ${moreImage![0].path} and seeeeeco is ${moreImage![1].path}');
    return

      typeSelect == 2
        ? moreImage!.isEmpty
            ? SizedBox(
                height: 350.w,
                width: 350.w,
                child: Center(
                  child: Text(
                    'No Photo Uploaded Yet ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ))
            : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                    child: moreImage![0].path == null
                        ? const SizedBox()
                        : CashImage(path: moreImage![0].path!)),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                    child: moreImage![1].path == null
                        ? const SizedBox()
                        : CashImage(path: moreImage![1].path!))
              ])
        : myId == userId?imagePic == null
            ? SizedBox(
                child: Center(
                    child: Text(
                'No Photo Uploaded Yet ',
                style: Theme.of(context).textTheme.bodySmall,
              )))
            : Align(
                alignment: Alignment.topLeft,
                child: CashImage(path: imagePic!)):const SizedBox();
  }
}
