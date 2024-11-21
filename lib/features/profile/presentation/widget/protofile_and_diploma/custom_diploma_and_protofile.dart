import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/features/profile/data/models/provider_model/image.dart';
import 'package:snipp/features/profile/domain/entities/provider_profile/provider_profile_image.dart';
import 'package:snipp/features/profile/presentation/screens/edit_image_screen.dart';
import 'package:snipp/features/profile/presentation/widget/protofile_and_diploma/diploma_and_protofile.dart';
import 'package:snipp/features/profile/presentation/widget/protofile_and_diploma/row_of_images.dart';

class CustomDiplomaAndProtofile extends StatefulWidget {
  final String imageCertificate;
  final List<ProviderProfileImage> images;
  const CustomDiplomaAndProtofile(
      {required this.images, required this.imageCertificate, super.key});

  @override
  State<CustomDiplomaAndProtofile> createState() =>
      _CustomDiplomaAndProtofileState();
}

//take diploma and protofile image form api
class _CustomDiplomaAndProtofileState extends State<CustomDiplomaAndProtofile> {
  int typeSelect = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Images',
              style: TextStyle(
                fontSize: 25.sp,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditImageScreen()));
                },
                icon: Icon(Icons.edit))
          ],
        ),
        SizedBox(
          height: 25.h,
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                  onTap: () {
                    setState(() {
                      typeSelect = 1;
                    });
                  },
                  child: DiplomaAndProtofile(
                      active: typeSelect == 1, type: 1, text: 'Diploma')),
            ),
            Expanded(
              child: InkWell(
                  onTap: () {
                    setState(() {
                      typeSelect = 2;
                    });
                  },
                  child: DiplomaAndProtofile(
                      active: typeSelect == 2, type: 2, text: 'Protofile')),
            ),
          ],
        ),
        // SizedBox(height: 15.h),

        // ///here i have to pass the list of diploma or protofile
        // ///depend on the typeSelect (using if to choose which list)
        RowOfImages(
          typeSelect: typeSelect,
           moreImage: widget.images,
          imagePic: widget.imageCertificate,
        ),
      ],
    );
  }
}
