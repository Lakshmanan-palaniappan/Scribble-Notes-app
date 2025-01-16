import 'package:awesome_notes/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../modals/note.dart';
import 'note_card.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key,required this.notes});
  final List<Notes> notes;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: notes.length,
      clipBehavior: Clip.none,
      itemBuilder: (context,index) {

        return Tasks(
          notes: notes[index],
          isGrid: false,);

      },
      separatorBuilder: (context,index)=>SizedBox(height: 4,),
    );
  }
}
