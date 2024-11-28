import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/constant.dart';
import 'package:snipp/core/resources/color_manager.dart';
import 'package:snipp/core/utils/ui_utils.dart';
import 'package:snipp/features/profile/data/models/provider_model/image.dart';
import 'package:snipp/features/profile/domain/entities/provider_profile/provider_profile_image.dart';
import 'package:snipp/features/profile/presentation/screens/edit_image_screen.dart';
import 'package:snipp/features/profile/presentation/widget/protofile_and_diploma/diploma_and_protofile.dart';
import 'package:snipp/features/profile/presentation/widget/protofile_and_diploma/row_of_images.dart';
import 'package:snipp/main.dart';

class CustomDiplomaAndProtofile extends StatefulWidget {
  final String imageCertificate;
  final int userId;
  final int isApprovid;
  final List<ProviderProfileImage> images;
  const CustomDiplomaAndProtofile(
      {required this.images, required this.imageCertificate,required this.userId,required this.isApprovid  ,super.key});

  @override
  State<CustomDiplomaAndProtofile> createState() =>
      _CustomDiplomaAndProtofileState();
}

//take diploma and protofile image form api
class _CustomDiplomaAndProtofileState extends State<CustomDiplomaAndProtofile> {
  int typeSelect = 1;
  @override
  Widget build(BuildContext context) {
    final myId=sharedPref.getInt(CacheConstant.userId);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Images', style: Theme.of(context).textTheme.labelLarge),
         myId==widget.userId?IconButton(
                onPressed:widget.isApprovid==1? () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditImageScreen()));
                }:(){
                  UIUtils.showMessage('You Have to wait to Accept your Informations');
                },
                icon: Icon(Icons.edit,color:widget.isApprovid==1? Colors.yellow:Colors.grey,)):const SizedBox()
          ],
        ),
        SizedBox(
          height: 25.h,
        ),
        Row(
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
                      active: typeSelect == 1, type: 1, text: 'Certificate')),
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
                      active: typeSelect == 2, type: 2, text: 'Photos')),
            ),
          ],
        ),
        // SizedBox(height: 15.h),

        // ///here i have to pass the list of diploma or protofile
        // ///depend on the typeSelect (using if to choose which list)
        SizedBox(
          height: 30.h,
        ),
        RowOfImages(
          typeSelect: typeSelect,
          moreImage: widget.images,
          imagePic: widget.imageCertificate,
        ),
      ],
    );
  }
}
