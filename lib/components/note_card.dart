import 'package:awesome_notes/Pages/newNote.dart';
import 'package:awesome_notes/change_notifier/new_note_controller.dart';
import 'package:awesome_notes/change_notifier/notes_provider.dart';
import 'package:awesome_notes/utils/constants.dart';
import 'package:awesome_notes/utils/dialogs.dart';
import 'package:awesome_notes/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../modals/note.dart';
import 'note_tag.dart';

class Tasks extends StatelessWidget {
  bool isGrid;
  Tasks({
    super.key,
    required this.isGrid,
    required this.notes
  });
  final Notes notes;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context)=>ChangeNotifierProvider(
                  create: (_)=>NewNoteController()..note=notes,
                    child: Newnote(isNewnote: false)))
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              width: 2,
              color: primary
          ),
          boxShadow: [
            BoxShadow(
                color: primary.withValues(alpha: 0.5),
                offset: Offset(4, 4)

            )
          ],
        ),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(notes.title!=null)...[
            Text(
              notes.title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: grey900
              ),
            ),
            SizedBox(height: 4,),],
            if(notes.tags!=null)...[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: List.generate(notes.tags!.length, (index)=>NoteTag(
                    label: notes.tags![index],
                  )
                  )
              ),
            ),
            SizedBox(height: 4,),],
            if(notes.content!=null)...[
            isGrid?Expanded(
                child: Text(
                  notes.content!,
                  style: TextStyle(
                      color: grey700
                  ),
                )
            )
                :Text(
              notes.content!,
              maxLines: 3,
              style: TextStyle(
                  color: grey700
              ),
            ),],
            if(isGrid)Spacer(),
            Row(
              children: [
                Text(
                  toShortDate(notes.dateCreated),
                  style: TextStyle(
                      fontSize: 12,
                      color: grey500,
                      fontWeight: FontWeight.w600,

                  ),
                ),
                Spacer(),
                IconButton(
                    onPressed: ()async {
                      final shouldDelete=await showConfirmationDialog(
                          context: context,
                        title: "Do You Want To Delete The Note?",
                      )?? false;
                      if(shouldDelete==true && context.mounted){
                        context.read<NotesProvider>().removeNote(notes);
                      }

                    },
                    icon: FaIcon(
                      FontAwesomeIcons.trash,
                      size: 16,
                      color: grey500,
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

