import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/profile/view/screen/profile_screen.dart';

import '../../../shared/image_functions.dart';

class DeplomaProtofileImageScreen extends StatefulWidget {
  DeplomaProtofileImageScreen({super.key});

  static const String routeName = '/deploma';

  @override
  State<DeplomaProtofileImageScreen> createState() =>
      _DeplomaProtofileImageScreenState();
}

class _DeplomaProtofileImageScreenState
    extends State<DeplomaProtofileImageScreen> {
  File? pickedImage;
  List<File> profileImages = [];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F8FF),
      appBar: AppBar(
        backgroundColor: Color(0xFFF0F8FF),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Upload Deploma Image",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36.sp,
                  fontFamily: "WorkSans"),
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: () {
                singleDialog();
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: pickedImage == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image, size: 40, color: Colors.blue),
                            SizedBox(height: 8),
                            Text("Upload Diploma Image",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.blue)),
                          ],
                        )
                      : Image.file(pickedImage!, fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Upload Deploma Image",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36.sp,
                  fontFamily: "WorkSans"),
            ),  SizedBox(height: 10.h),
        Wrap(
          spacing: 10,
          children: List.generate(profileImages.length + 1, (index) {
            return GestureDetector(
              onTap: index == profileImages.length ? multiDialog : null,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue, width: 1.5),
                ),
                child: index == profileImages.length
                    ? Center(child: Icon(Icons.add_a_photo, color: Colors.blue))
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(profileImages[index], fit: BoxFit.cover),
                ),
              ),
            );
          }),
        ) ,
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 20.h),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(TestWidget.routeName,
                  );
                },
                child: Text(
                  "Next",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r))),
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 12.h))),
              ),
            ),

          ],
        ),
      ),
    );
  }

  singleDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () async {
                        File? temp = await ImageFunctions.CameraPicker();
                        if (temp != null) {
                          pickedImage = temp;
                        }
                        Navigator.pop(context);
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        size: 40,
                        color: Colors.blue,
                      )),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text("camera")
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () async {
                        File? temp = await ImageFunctions.galleryPicker();
                        if (temp != null) {
                          pickedImage = temp;
                        }
                        Navigator.pop(context);

                        setState(() {});
                      },
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        size: 40,
                        color: Colors.blue,
                      )),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text("gallery")
                ],
              ),
            ],
          ),
        ));
  }
  multiDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () async {
                        File? temp = await ImageFunctions.CameraPicker();
                        if (temp != null) {
                          profileImages.add(temp);
                        }
                        Navigator.pop(context);
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        size: 40,
                        color: Colors.blue,
                      )),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text("camera")
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () async {
                        List<File>? temps = await ImageFunctions.galleryImagesPicker();
                        if (temps != null) {
                          profileImages = temps;
                        }
                        Navigator.pop(context);

                        setState(() {});
                      },
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        size: 40,
                        color: Colors.blue,
                      )),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text("gallery")
                ],
              ),
            ],
          ),
        ));
  }
}
