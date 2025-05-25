import 'package:app/features/profile/domain/entities/provider_profile/provider_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/constant.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile_image.dart';

import 'package:app/features/profile/presentation/widget/protofile_and_diploma/diploma_and_protofile.dart';
import 'package:app/features/profile/presentation/widget/protofile_and_diploma/row_of_images.dart';
import 'package:app/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomDiplomaAndProtofile extends StatefulWidget {
  final String imageCertificate;
  final int userId;
  final bool isApprovid;
  final List<ProviderProfileImage> images;
  const CustomDiplomaAndProtofile(
      {required this.images,
      required this.imageCertificate,
      required this.userId,
      required this.isApprovid,
      super.key});

  @override
  State<CustomDiplomaAndProtofile> createState() =>
      _CustomDiplomaAndProtofileState();
}

//take diploma and protofile image form api
class _CustomDiplomaAndProtofileState extends State<CustomDiplomaAndProtofile> {
  int typeSelect = 1;
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    // print(
    //     'the list of provider profile imaghe is ${widget.images[0].path} and second is ${widget.images[1].path}');
    final myId = sharedPref.getInt(CacheConstant.userId);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(localization.images,
                style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        SizedBox(
          height: 25.h,
        ),
        myId == widget.userId
            ? Row(
                children: [
                  Expanded(
                    child: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            typeSelect = 1;
                          });
                        },
                        child: DiplomaAndProtofile(
                            active: typeSelect == 1,
                            type: 1,
                            text: localization.certificate)),
                  ),
                  Expanded(
                    child: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            typeSelect = 2;
                          });
                        },
                        child: DiplomaAndProtofile(
                            active: typeSelect == 2,
                            type: 2,
                            text: localization.photos)),
                  ),
                ],
              )
            : const SizedBox(),
        SizedBox(
          height: 30.h,
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.1),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: RowOfImages(
            key: ValueKey<int>(typeSelect), // مهم للتمييز بين التابين
            userId: widget.userId,
            typeSelect: typeSelect,
            moreImage: widget.images,
            imagePic: widget.imageCertificate,
          ),
        ),

        SizedBox(height: 75.h),

        const  Divider(color: Colors.grey, thickness: 0.2),

      ],
    );
  }
}
