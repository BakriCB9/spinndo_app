import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/auth/view/log_in/sign_in_screen.dart';
import 'package:snipp/auth/view/screen/employee_details.dart';
import 'package:snipp/auth/view/screen/upload_profile_image.dart';
import 'package:snipp/profile/view/screen/profile_screen.dart';

import '../../../shared/image_functions.dart';
import '../screen/verfication_code_screen.dart';

class AccountTypeScreen extends StatefulWidget {
   AccountTypeScreen({super.key});
  static const String routeName = '/account';

  @override
  State<AccountTypeScreen> createState() => _AccountTypeScreenState();
}

class _AccountTypeScreenState extends State<AccountTypeScreen> {
   bool isClient = true;
   File? pickedImage;

  @override
  Widget build(BuildContext context) {    double avatarRadius = MediaQuery.of(context).size.width * 0.3;
  final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFF0F8FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Congurations",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28.sp,
                  fontFamily: "WorkSans"),
            ),
            Spacer(),
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
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(onPressed: () {
                        dialog();
                      },
                     icon: Icon(   Icons.camera_alt,
                        color: Colors.white,
                        size: avatarRadius * 0.15,
                      ),)
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ()  {
                  dialog();
                },
                child: Text(
                  "Upload Profile Image",
                  style: TextStyle(fontSize: 20.sp, color: Colors.white),
                ),
                style:  ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r))),
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 12.h))),
              ),
            ),

            Spacer(),            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

             Text(
                  "Choose your account type:",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 22.sp,
                      fontFamily: "WorkSans"),
                ),

              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        activeColor: Colors.blue,
                        hoverColor: Colors.blue,
                        groupValue: isClient,
                        onChanged: (value) {
                          setState(() {
                            isClient = value!;
                          });
                        },
                      ),
                      Text(
                        'Client',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  SizedBox(width: 16),
                  Row(
                    children: [
                      Radio<bool>(
                        activeColor: Colors.blue,
                        hoverColor: Colors.blue,
                        value: false,
                        groupValue: isClient,
                        onChanged: (value) {
                          setState(() {
                            isClient = value!;
                          });
                        },
                      ),
                      Text('Employee', style: TextStyle(fontSize: 20))
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),

            Container(
              margin: EdgeInsets.only(bottom: 50.h),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {

                  isClient?Navigator.of(context).pushNamed(TestWidget.routeName,arguments: pickedImage):Navigator.of(context).pushNamed(EmployeeDetails.routeName,arguments: pickedImage);

                },
                child: Text(
                  "Next",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
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
   dialog(){
     showDialog(context: context, builder:(context)=>AlertDialog(content: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
       Column(mainAxisAlignment:MainAxisAlignment.center,mainAxisSize: MainAxisSize.min, children: [
         IconButton(onPressed: () async{
           File? temp = await ImageFunctions.CameraPicker();
           if (temp != null) {
             pickedImage = temp;
           }
           Navigator.pop(context);
           setState(() {});
         }, icon: Icon(Icons.camera_alt_outlined,size: 40,color: Colors.blue,)),SizedBox(height: 3.h,),Text("camera")
       ],),Column(mainAxisAlignment:MainAxisAlignment.center,mainAxisSize: MainAxisSize.min, children: [
         IconButton(onPressed: () async{
           File? temp = await ImageFunctions.galleryPicker();
           if (temp != null) {
             pickedImage = temp;
           }           Navigator.pop(context);

           setState(() {});
         }, icon: Icon(Icons.camera_alt_outlined,size: 40,color: Colors.blue,)),SizedBox(height: 3.h,),Text("gallery")
       ],),
     ],),));
   }
}
