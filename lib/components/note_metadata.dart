import 'package:awesome_notes/change_notifier/new_note_controller.dart';
import 'package:awesome_notes/utils/dialogs.dart';
import 'package:awesome_notes/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../modals/note.dart';
import '../utils/constants.dart';
import 'dialog_card.dart';
import 'newnote_dialog.dart';
import 'note_tag.dart';

class NoteMetaData extends StatefulWidget {
  NoteMetaData({
    super.key,
    required this.isNewnote,
    required this.note,
  });
  final bool isNewnote;
  final Notes? note;

  @override
  State<NoteMetaData> createState() => _NoteMetaDataState();
}

class _NoteMetaDataState extends State<NoteMetaData> {
  late final NewNoteController newNoteController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newNoteController=context.read();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(!widget.isNewnote)
          ...[Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  "Created",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: grey300
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  toLongDate(widget.note!.dateCreated),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: grey900
                  ),
                ),
              )
            ],
          ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    "Last Modified",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: grey300
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    toLongDate(widget.note!.dateModified),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: grey900
                    ),
                  ),
                )
              ],
            ),],
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Text(
                    "Tags",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: grey300
                    ),
                  ),
                  SizedBox(width: 8,),
                  IconButton(
                    onPressed: ()async {
                      final String? tag=await showNewTagDialog(context: context);
                      if(tag!=null){
                        newNoteController.addTags(tag);
                      }
                    },
                    icon: Icon(FontAwesomeIcons.circlePlus),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    visualDensity: VisualDensity.compact,

                    style: IconButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap

                    ),
                    iconSize: 18,
                  )
                ],
              ),
            ),
            Expanded(
                flex: 5,
                child: Selector<NewNoteController,List<String>>(
                  selector: (_,newNoteController)=>newNoteController.tags,
                  builder:(_,tags,__) =>tags.isEmpty?Text(
                    "No Tags Added",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: grey900
                    ),
                  ): SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children:
                        List.generate(
                            tags.length,
                                (index)=>NoteTag(
                              label: tags[index],
                              onClosed: (){
                                newNoteController.removeTag(index);
                              },
                                  onTap: () async{
                                final String?tag=await showNewTagDialog(
                                    context: context,
                                    tag: tags[index]
                                );
                                if(tag!=null && tag!=tags[index]){
                                  newNoteController.updateTag(tag,index);
                                }

                                  },
                            )
                        )

                    ),
                  ),
                )
            ),

          ],
        ),

      ],
    );
  }
}
