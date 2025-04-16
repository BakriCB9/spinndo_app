import 'package:flutter/material.dart';

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
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          enabled: true,
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey))),
    );
  }
}
