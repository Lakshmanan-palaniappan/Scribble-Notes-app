import 'package:awesome_notes/components/messageDialog.dart';
import 'package:flutter/material.dart';

import '../components/confirmation_dialog.dart';
import '../components/dialog_card.dart';
import '../components/newnote_dialog.dart';

Future<String?> showNewTagDialog({ required BuildContext context,String? tag}){
  return showDialog<String?>(context: context, builder: (context)=>
      DialogCard(
        child: NewtagDialog(tag: tag,),
      )

  );
}

Future<bool?>showConfirmationDialog({
  required BuildContext context,
  required String title,
}){
  return showDialog<bool?>(context: context, builder: (_)=>DialogCard(
    child: ConfirmationDialog(
      title: title,
    ),
  )
  );



}
Future<bool?>showMessageDialog({
  required BuildContext context,
  required String message,

}){
  return showDialog<bool?>(context: context, builder: (_)=>Messagedialog(
    message: message,)
  );

}