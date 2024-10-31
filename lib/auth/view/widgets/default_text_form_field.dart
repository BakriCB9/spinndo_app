import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultTextFormField extends StatefulWidget {
  final String? hintText;
  final int? maxLines;
  final int? minLines;
  final String? labelText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool isPassword;
final IconData icon;
  const DefaultTextFormField(
      {Key? key,
      this.labelText,
      this.validator,
      this.isPassword = false,
      this.hintText,
        this.maxLines = 1,
        this.minLines = 1,
      required this.controller, required this.icon})
      : super(key: key);

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  bool isObsecure = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(

      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,

        label: widget.labelText != null
            ? Text(
                widget.labelText!,style: TextStyle(color: Colors.blue.shade600),

              )
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  isObsecure = !isObsecure;
                  setState(() {});
                },
                icon: isObsecure
                    ? const Icon(Icons.visibility_off_outlined)
                    : const Icon(Icons.visibility_outlined))
            : null,
        prefixIcon: Icon(widget.icon, color: Colors.blue),
          enabled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black,width: 1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder:OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black,width: 1),
            borderRadius: BorderRadius.circular(8.0),
          ) ,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black,width: 1),
      borderRadius: BorderRadius.circular(8.0),
    ),
        // counter: SizedBox()
      ),
      obscureText: isObsecure,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      validator: widget.validator,
      keyboardType: TextInputType.multiline,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.newline,
      inputFormatters: [
        LengthLimitingTextInputFormatter(200),
      ],
      // maxLength: 10,
    );
  }
}
