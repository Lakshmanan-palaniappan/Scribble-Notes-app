import 'package:flutter/material.dart';

import '../utils/constants.dart';

class NoteFormWidget extends StatelessWidget {
  NoteFormWidget({
    super.key,
    //required this.tagkey,
    this.controller,
    this.hintText,
    this.validator,
    this.onChanged,
    this.autofocus=false,
    this.fillcolor,
    this.filled,
    this.labelText,
    this.suffixIcon,
    this.isObscure=false,
    this.textCapitalization = TextCapitalization. none,
    this.textInputAction,
    this.keyboardType,

  });

  //final GlobalKey<FormFieldState> tagkey;
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool autofocus;
  final bool? filled;
  final Color? fillcolor;
  final String? labelText;
  final Widget? suffixIcon;
  final bool isObscure;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  TextInputType? keyboardType;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validator,
        key: key,
        obscureText: isObscure,
        autofocus: autofocus,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 14,
          ),

          contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
          isDense: true,
          //border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: primary
              )
          ),
          suffixIcon: suffixIcon,
          filled: filled,
          fillColor: fillcolor,
          labelText: labelText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: primary
              )
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: Colors.red
              )
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: Colors.red
              )
          ),



        ),
        onChanged: onChanged,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      keyboardType: keyboardType,

    );
  }
}