import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFromFieldBakri extends StatefulWidget {
  final String label;
  // final String? content;
  final String? initialvalue;
  final IconData? icon;
  final int? maxlines;
  const CustomTextFromFieldBakri(
      {required this.label,
      this.maxlines,
      this.icon,
      this.initialvalue,
      super.key});

  @override
  State<CustomTextFromFieldBakri> createState() =>
      _CustomTextFromFieldBakriState();
}

class _CustomTextFromFieldBakriState extends State<CustomTextFromFieldBakri> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxlines,
      style: Theme.of(context).textTheme.bodyMedium,
      initialValue: widget.initialvalue,

      decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          label: Text(
            widget.label,

          ),
          prefixIcon: Icon(
            widget.icon,
            color: Theme.of(context).primaryColorLight,
          ),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          enabled: true,
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
    );
  }
}
