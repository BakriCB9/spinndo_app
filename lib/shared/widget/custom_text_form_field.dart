import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFromField extends StatefulWidget {
  final String label;
  // final String? content;
  final String? initialvalue;
  final IconData ?icon;
  final int? maxlines;
  const CustomTextFromField(
      {required this.label,this.maxlines ,this.icon,this.initialvalue, super.key});

  @override
  State<CustomTextFromField> createState() => _CustomTextFromFieldState();
}

class _CustomTextFromFieldState extends State<CustomTextFromField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines:widget.maxlines ,
      
      style: TextStyle(fontSize: 13.sp, color: Colors.grey),
      initialValue: widget.initialvalue,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
          label: Text(
            widget.label,
            style: TextStyle(color: Colors.blue, fontSize: 17.sp),
          ),
          
          prefixIcon: Icon(
            widget.icon,
            color: Colors.grey,
          ),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          enabled: true,
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
    );
  }
}
