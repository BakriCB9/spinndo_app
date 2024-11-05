import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final int? maxLines;
  final int? minLines;
  final String? labelText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool isPassword;
  final IconData? icon;
final TextInputType?keyboardType;
  const CustomTextFormField(
      {Key? key,
      this.labelText,
      this.validator,
      this.isPassword = false,
      this.hintText,
      this.maxLines = 1,
      this.minLines = 1,
      required this.controller,
       this.icon, this.keyboardType})
      : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormField();
}

class _CustomTextFormField extends State<CustomTextFormField> {
  bool isObsecure = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        color: Colors.white
      ),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,

          label: widget.labelText != null
              ? Text(
                  widget.labelText!,
                  style: TextStyle(fontWeight: FontWeight.w300,color: Colors.grey.shade700),
                )
              : null,
          suffixIcon: widget.controller.text.isNotEmpty? widget.isPassword
              ? IconButton(
            style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.blue.shade300)),
                  onPressed: () {
                    isObsecure = !isObsecure;
                    setState(() {});
                  },
                  icon: isObsecure
                      ? const Icon(Icons.visibility_off_outlined)
                      : const Icon(Icons.visibility_outlined))
              : null:null,
          prefixIcon: Icon(widget.icon, color: Colors.blue.shade300),
          enabled: true,

          filled: false,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          // counter: SizedBox()
        ),
        onChanged:widget.isPassword? (value) {
          setState(() {

          });
        }:null,
        obscureText: isObsecure,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        validator: widget.validator,
        keyboardType: widget.keyboardType??TextInputType.multiline,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.newline,
        inputFormatters: [
          LengthLimitingTextInputFormatter(200),
        ],
        // maxLength: 10,
      ),
    );
  }
}
