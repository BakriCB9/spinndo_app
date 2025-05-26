import 'package:app/core/constant.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../core/widgets/cash_network.dart';

class RowOfImages extends StatelessWidget {
  String? imagePic;
  List<ProviderProfileImage>? moreImage;
  int typeSelect;
  int userId;

  RowOfImages(
      {required this.userId,
      required this.typeSelect,
      this.imagePic,
      this.moreImage,
      super.key});

  ///here i have to take list of images for protofile or diploma
  final myId = sharedPref.getInt(CacheConstant.userId);
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    if (myId != userId) {
      typeSelect = 2;
    }
       return typeSelect == 2
        ? moreImage!.isEmpty
            ? SizedBox(
                height: 200.w,
                width: double.infinity,
                child: Center(
                  child: Text(
                    localization.noPhotoYet,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ))
            : Builder(builder: (context) {
                // Get screen width
                double screenWidth = MediaQuery.of(context).size.width;
                double widt = (screenWidth / 2) - 20;
                return Wrap(
                    spacing: 20.0, // Spacing between items horizontally
                    runSpacing: 10.0, // Spacing between rows
                    alignment: WrapAlignment.start,
                    children: List.generate(
                        moreImage!.length, // Number of images
                        (index) => SizedBox(
                              width: widt,
                              height: widt,
                              child: Center(
                                  child:
                                      CashImage(path: moreImage![index].path!)),
                            )));
              })
        : myId == userId
            ? imagePic == null
                ? SizedBox(
                    child: Center(
                        child: Text(
                    localization.noPhotoYet,
                    style: Theme.of(context).textTheme.bodySmall,
                  )))
                : Align(
                    alignment: Alignment.topLeft,
                    child: CashImage(path: imagePic!))
            : const SizedBox();
  }
}
