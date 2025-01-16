import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/constants.dart';

class NoteTag extends StatelessWidget {
  const NoteTag({
    super.key,
    this.onClosed,
    required this.label,
    this.onTap
  });
  final String label;
  final VoidCallback? onClosed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration:BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: grey100,

          ),
          margin: EdgeInsets.only(right: 4),
          padding:EdgeInsets.symmetric(
              vertical:2, horizontal:12
          ),

          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(
                    fontSize: 12,
                    color: grey700
                ),

              ),
              if(onClosed!=null) ...[
                SizedBox(width: 4,),
                GestureDetector(
                  onTap: onClosed ,
                    child: Icon(FontAwesomeIcons.close,size: 18,))
              ]
            ],
          )
      ),
    );
  }
}