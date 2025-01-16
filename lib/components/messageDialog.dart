import 'package:awesome_notes/components/dialog_card.dart';
import 'package:flutter/material.dart';

import 'note_button.dart';

class Messagedialog extends StatelessWidget {
  const Messagedialog({
    super.key,
    required this.message,
  });
  final String message;

  @override
  Widget build(BuildContext context) {
    return DialogCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            message,
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
              NoteButton(child: Text("Ok"), onPressed: (){
                Navigator.pop(context);
              }),

            ],
          )
        ],
      ),
    );
  }
}