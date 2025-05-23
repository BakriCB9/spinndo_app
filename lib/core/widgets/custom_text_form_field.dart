import 'package:app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
typedef Change =void Function(String)?;
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
  final Change onChanged;

  const CustomTextFormField(
      {Key? key,
      this.labelText,
      this.onChanged,
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
    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        focusNode: _focus,
        style: Theme.of(context).textTheme.bodyMedium,

        decoration: InputDecoration(

            hintText: widget.hintText,
            hintStyle:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 30.sp),
            labelStyle:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 27.sp),
            label: widget.labelText != null
                ? Text(
                    widget.labelText!,
                  )
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      isObsecure = !isObsecure;
                      setState(() {});
                    },
                    icon: Icon(
                        isObsecure ? Icons.visibility : Icons.visibility_off))
                : null,

            prefixIcon: widget.icon == null
                ? null
                : Icon(
                    widget.icon,
                    size: 45.sp,
                  ),
            enabled: true,
            contentPadding: EdgeInsets.only(left: 50.w)

            ),
        onChanged:widget.onChanged ,
        cursorColor: ColorManager.primary,
        obscureText: widget.isPassword ? !isObsecure : false,
        controller: widget.controller,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        validator: widget.validator,
        keyboardType: widget.keyboardType ?? TextInputType.multiline,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: [
          LengthLimitingTextInputFormatter(200),
        ],

      ),
    );
  }
}
