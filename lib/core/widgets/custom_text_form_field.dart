import 'package:app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/resources/font_manager.dart';
import 'package:app/core/resources/styles_manager.dart';
import 'package:app/core/resources/theme_manager.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final int? maxLines;
  final int? minLines;
  final String? labelText;
  final double? padding;
  final String? initValue;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool isPassword;
  final IconData? icon;
  final TextInputType? keyboardType;

  const CustomTextFormField(
      {Key? key,
      this.labelText,
      this.validator,
      this.isPassword = false,
      this.hintText,
      this.maxLines = 1,
      this.minLines = 1,
      this.padding = 0,
      this.initValue,
      required this.controller,
      this.icon,
      this.keyboardType})
      : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormField();
}

class _CustomTextFormField extends State<CustomTextFormField> {
  bool isObsecure =  false;
  late FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _focus = FocusNode();
  }

  @override
  dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //initialValue:null ,

      focusNode: _focus,
      onTapOutside: (_) {
        _focus.unfocus();
      },
      onFieldSubmitted: (_) {
        _focus.unfocus();
      },
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle:
              Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 30.sp),
          label: widget.labelText != null
              ? Text(
                  widget.labelText!,
                )
              : null,
          suffixIcon: widget.controller.text.isNotEmpty
              ? widget.isPassword
                  ? IconButton(
                      onPressed: () {
                        isObsecure = !isObsecure;
                        setState(() {});
                      },
                      icon: isObsecure

                          ? Icon(
                              Icons.visibility_outlined,
                              size: 40.sp,
                            ): Icon(
            Icons.visibility_off_outlined,
            size: 40.sp,
          ))
                  : null
              : null,
          prefixIcon: widget.icon == null
              ? null
              : Icon(
                  widget.icon,
                  size: 45.sp,
                ),
          enabled: true,
          contentPadding: EdgeInsets.only(left: widget.padding ?? 0)
          // counter: SizedBox()
          ),
      onChanged: widget.isPassword
          ? (value) {
              setState(() {});
            }
          : null,
      cursorColor: ColorManager.primary,
      obscureText: widget.isPassword? !isObsecure:isObsecure,
      controller: widget.controller,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      validator: widget.validator,
      keyboardType: widget.keyboardType ?? TextInputType.multiline,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.done,
      inputFormatters: [
        LengthLimitingTextInputFormatter(200),
      ],
      // maxLength: 10,
    );
  }
}
