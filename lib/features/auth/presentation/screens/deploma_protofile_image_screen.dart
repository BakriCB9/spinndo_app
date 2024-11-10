import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/features/auth/data/models/register_service_provider_request.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snipp/features/auth/presentation/screens/verfication_code_screen.dart';
import 'package:snipp/features/profile/presentation/screens/profile_screen.dart';

import '../../../../core/utils/image_functions.dart';

class DeplomaProtofileImageScreen extends StatefulWidget {
  DeplomaProtofileImageScreen({super.key});

  static const String routeName = '/deploma';

  @override
  State<DeplomaProtofileImageScreen> createState() =>
      _DeplomaProtofileImageScreenState();
}

class _DeplomaProtofileImageScreenState
    extends State<DeplomaProtofileImageScreen> {
  final _authCubit = serviceLocator.get<AuthCubit>();

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
                  child: _authCubit.pickedImage == null
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
                      : Image.file(_authCubit.pickedImage!, fit: BoxFit.cover),
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
            ),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 10,
              children:
                  List.generate(_authCubit.profileImages.length + 1, (index) {
                return GestureDetector(
                  onTap: index == _authCubit.profileImages.length
                      ? multiDialog
                      : null,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue, width: 1.5),
                    ),
                    child: index == _authCubit.profileImages.length
                        ? Center(
                            child: Icon(Icons.add_a_photo, color: Colors.blue))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(_authCubit.profileImages[index],
                                fit: BoxFit.cover),
                          ),
                  ),
                );
              }),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 20.h),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _authCubit.registerService(RegisterServiceProviderRequest(
                      first_name: _authCubit.firstNameContoller.text,
                      last_name: _authCubit.lastNameContoller.text,
                      email: _authCubit.emailController.text,
                      working_days: _authCubit.dateSelect,
                      password: _authCubit.passwordController.text,
                      nameService: _authCubit.serviceNameController.text,
                      descriptionService:
                          _authCubit.serviceDescriptionController.text,
                      categoryIdService: _authCubit.categoryId,
                      cityIdService: _authCubit.cityId,
                      websiteService: _authCubit.website,
                      certificate:  _authCubit.pickedImage!,
                      longitudeService: "-122.4194",
                      latitudeService: "37.7749",
                      images: [
                        _authCubit.profileImages[0],
                        _authCubit.profileImages[1]
                      ]));
                  Navigator.of(context).pushNamed(
                    VerficationCodeScreen.routeName,
                  );
                },
                child: Text(
                  "Sign Up",
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
                              _authCubit.pickedImage = temp;
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
                              _authCubit.pickedImage = temp;
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
                              _authCubit.profileImages.add(temp);
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
                            List<File>? temps =
                                await ImageFunctions.galleryImagesPicker();
                            if (temps != null) {
                              _authCubit.profileImages = temps;
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
