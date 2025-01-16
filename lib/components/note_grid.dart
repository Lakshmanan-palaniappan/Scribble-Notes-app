import 'package:awesome_notes/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../modals/note.dart';
import 'note_card.dart';

class NotesGrid extends StatefulWidget {
  const NotesGrid({
    super.key,
    required this.notes
  });
  final List<Notes> notes;

  @override
  State<NotesGrid> createState() => _NotesGridState();
}

class _NotesGridState extends State<NotesGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4
        ),
        itemCount: widget.notes.length,
        itemBuilder: (context,int index){
          return Tasks(
            notes: widget.notes[index],
            isGrid: true,);
        }
    );
  }
}