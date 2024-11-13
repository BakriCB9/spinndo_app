import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snipp/features/profile/presentation/screens/edit_image_screen.dart';
import 'package:snipp/features/profile/presentation/widget/protofile_and_diploma/diploma_and_protofile.dart';
import 'package:snipp/features/profile/presentation/widget/protofile_and_diploma/row_of_images.dart';

class CustomDiplomaAndProtofile extends StatefulWidget {
  const CustomDiplomaAndProtofile({super.key});

  @override
  State<CustomDiplomaAndProtofile> createState() =>
      _CustomDiplomaAndProtofileState();
}

//take diploma and protofile image form api
class _CustomDiplomaAndProtofileState extends State<CustomDiplomaAndProtofile> {
  final _authCubit = serviceLocator.get<AuthCubit>();
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
        SizedBox(height: 15.h),

        ///here i have to pass the list of diploma or protofile
        ///depend on the typeSelect (using if to choose which list)
        RowOfImages(
          typeSelect: typeSelect,
          moreImage: typeSelect == 2
              ? _authCubit.profileImages:null,
          imagePic: typeSelect==1?_authCubit.pickedImage:null,
        ),
      ],
    );
  }
}