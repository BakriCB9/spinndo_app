import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/auth/view/log_in/sign_in_screen.dart';

class PickPictureDialog extends StatefulWidget {
  const PickPictureDialog({super.key});

  @override
  State<PickPictureDialog> createState() => _PickPictureDialogState();
}

class _PickPictureDialogState extends State<PickPictureDialog> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 70,backgroundColor: Colors.grey.shade300,child: Icon(Icons.person,size: 80,),
            ),Container(
              height: 135,width: 140,
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {


                },child: Icon(Icons.camera_alt_outlined,color: Colors.blue,size: 25,),
              ),
            )
          ],
        ),
      ],
    );
  }

  dialog(){
    showDialog(context: context, builder:(context)=>AlertDialog(content: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
      Column(mainAxisAlignment:MainAxisAlignment.center,mainAxisSize: MainAxisSize.min, children: [
        IconButton(onPressed: () {

        }, icon: Icon(Icons.camera_alt_outlined,size: 40,color: Colors.blue,)),SizedBox(height: 3.h,),Text("camera")
      ],),Column(mainAxisAlignment:MainAxisAlignment.center,mainAxisSize: MainAxisSize.min, children: [
        IconButton(onPressed: () {

        }, icon: Icon(Icons.camera_alt_outlined,size: 40,color: Colors.blue,)),SizedBox(height: 3.h,),Text("gallery")
      ],),
    ],),));
  }
}
