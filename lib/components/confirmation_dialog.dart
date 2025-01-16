import 'package:flutter/material.dart';

import 'note_button.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          title,
          style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 4,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            NoteButton(isOutlined:true,child: Text("No"), onPressed: (){
              Navigator.pop(context,false);

            }),
            SizedBox(width: 4,),
            NoteButton(child: Text("Yes"), onPressed: (){
              Navigator.pop(context,true);
            }),

          ],
        )
      ],
    );
  }
}