import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'note_button.dart';
import 'note_form_filed.dart';

class NewtagDialog extends StatefulWidget {
  const NewtagDialog({
    super.key,
    this.tag,
  });
  final String? tag;





  @override
  State<NewtagDialog> createState() => _NewtagDialogState();
}

class _NewtagDialogState extends State<NewtagDialog> {
  late final TextEditingController tagController;
  late final GlobalKey<FormFieldState> tagkey;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tagController=TextEditingController(text: widget.tag);
    tagkey=GlobalKey();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tagController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        Text(
          "Add Tag",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 24,),
        NoteFormWidget(
            key: tagkey,
            controller: tagController,
          hintText: "Add a Tag ( <16 Characters)",
          validator: (value){
            if(value!.trim().isEmpty){
              return 'No Tags Added';
            }else if(value!.trim().length>16){
              return 'Tags Should Be Only 16 Characters Long';
            }
            return null;
          },
          onChanged: (newValue){
            tagkey.currentState?.validate();
          },
          autofocus: true,
        ),
        SizedBox(height: 24,),
    NoteButton(

            //tagkey: tagkey,
            //tagController: tagController,
            child:Text( "Add"),onPressed: (){
            if(tagkey.currentState?.validate()??false){
              Navigator.pop(context,tagController.text.trim());

            }
          },),


      ],
    );
  }
}



