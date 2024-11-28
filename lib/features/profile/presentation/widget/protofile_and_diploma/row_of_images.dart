import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/features/profile/data/models/provider_model/image.dart';
import 'package:snipp/features/profile/domain/entities/provider_profile/provider_profile_image.dart';

import '../../../../../core/widgets/cash_network.dart';

class RowOfImages extends StatelessWidget {
  String? imagePic;
  List<ProviderProfileImage>? moreImage;
  int typeSelect;

  RowOfImages(
      {required this.typeSelect, this.imagePic, this.moreImage, super.key});

  ///here i have to take list of images for protofile or diploma
  @override
  Widget build(BuildContext context) {
    return typeSelect == 2
        ?
    moreImage!.isEmpty?  SizedBox(
        height: 350.w,
        width: 350.w,
        child: Center(child: Text('No Photo Uploaded Yet ',style: Theme.of(context).textTheme.bodySmall,),)):
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
          ]
            )
        : imagePic==null?SizedBox(child: Center(child:  Text('No Photo Uploaded Yet ',style: Theme.of(context).textTheme.bodySmall,))) :Align(
            alignment: Alignment.topLeft, child: CashImage(path: imagePic!));
  }
}
