import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/profile/view/screen/profile_screen.dart';

import '../../../shared/image_functions.dart';

class UploadProfileImage extends StatefulWidget {
   UploadProfileImage({super.key});

  static const String routeName = '/profile';

  @override
  State<UploadProfileImage> createState() => _UploadProfileImageState();
}

class _UploadProfileImageState extends State<UploadProfileImage> {
  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    double avatarRadius = MediaQuery.of(context).size.width * 0.3;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    child: CircleAvatar(
                      radius: avatarRadius * 0.7,
                      backgroundColor: Colors.grey,
                      backgroundImage:   pickedImage == null ? null : FileImage(pickedImage!),
                      child:pickedImage==null?Icon(
                        Icons.person,
                        size: avatarRadius,
                        color: Colors.white,
                      ):null,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: size.width / 80,
                    child: Container(
                      width: avatarRadius * 0.4,
                      height: avatarRadius * 0.4,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                        size: avatarRadius * 0.15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  File? temp = await ImageFunctions.galleryPicker();
                  if (temp != null) {
                    pickedImage = temp;
                  }
                  setState(() {});
                },
                child: Text(
                  "Upload Profile Image",
                  style: TextStyle(fontSize: 20.sp, color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r))),
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 10.h))),
              ),
            ), Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ()  {
                  Navigator.of(context).pushNamed(TestWidget.routeName);

                },
                child: Text(
                  "Next ->",
                  style: TextStyle(fontSize: 20.sp, color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r))),
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 10.h))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
