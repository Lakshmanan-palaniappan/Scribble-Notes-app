import 'package:flutter/material.dart';

import '../utils/constants.dart';

class NoteButton extends StatelessWidget {
  const NoteButton({
    super.key,
    //required this.tagkey,
    //required this.tagController,
    required this.child,
    required this.onPressed,
    this.isOutlined=false,
  });

  //final GlobalKey<FormFieldState> tagkey;
  final Widget child;
  final VoidCallback? onPressed;
  final bool isOutlined;
  //final TextEditingController tagController;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
        boxShadow: [
        BoxShadow(
        color: isOutlined?primary: black,
        offset: Offset(2, 2),

    ),
    ],
    borderRadius: BorderRadius.circular(8)
    ),
    child:ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined?white:primary,
          foregroundColor: isOutlined?primary:white,
          disabledBackgroundColor: grey300,
          disabledForegroundColor: black,
          side: BorderSide(
            color: isOutlined?primary:black,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),

          ),
          elevation: 0,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap


      ),
    )
    );
  }
}