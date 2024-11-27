import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/resources/font_manager.dart';
import 'package:snipp/core/resources/styles_manager.dart';
import 'package:snipp/core/resources/theme_manager.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final int? maxLines;
  final int? minLines;
  final String? labelText;
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
      required this.controller,
      this.icon,
      this.keyboardType})
      : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormField();
}

class _CustomTextFormField extends State<CustomTextFormField> {
  bool isObsecure = false;
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
                            Icons.visibility_off_outlined,
                            size: 40.sp,
                          )
                        : Icon(
                            Icons.visibility_outlined,
                            size: 40.sp,
                          ))
                : null
            : null,
        prefixIcon: Icon(
          widget.icon,
          size: 45.sp,
        ),
        enabled: true,

        // counter: SizedBox()
      ),
      onChanged: widget.isPassword
          ? (value) {
              setState(() {});
            }
          : null,
      obscureText: isObsecure, controller: widget.controller,
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
