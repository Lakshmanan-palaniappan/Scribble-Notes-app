import 'package:awesome_notes/Pages/newNote.dart';
import 'package:awesome_notes/change_notifier/new_note_controller.dart';
import 'package:awesome_notes/change_notifier/notes_provider.dart';
import 'package:awesome_notes/components/view_options.dart';
import 'package:awesome_notes/services/authService.dart';
import 'package:awesome_notes/utils/constants.dart';
import 'package:awesome_notes/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../components/floatingbutton.dart';
import '../components/nonote.dart';
import '../components/note_grid.dart';
import '../components/note_list.dart';
import '../components/searchfield.dart';
import '../modals/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>
                  ChangeNotifierProvider(
                    create: (context) => NewNoteController(),

                  child: Newnote(isNewnote: true,)))
          );
        },
      ),
      appBar: AppBar(
        title: Text("Awesome Notes"),
        actions: [
          IconButton(
              onPressed: () async{
               final bool shouldLogout=await  showConfirmationDialog(
                   context: context,
                   title: 'Do you want to sign out of the app'
               ) ?? false;
               if(shouldLogout){
                 AuthService.logout();

               }

              },
              icon:FaIcon(FontAwesomeIcons.rightFromBracket),
            style: IconButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
              ),
              side: BorderSide(
                color: black
              )
            ),
          )
        ],
      ),
      body: Consumer<NotesProvider>(
        builder:( context,notesProvider,child){
          final List<Notes> notes=notesProvider.notes;
          return notes.isEmpty && notesProvider.searchTerm.isEmpty? NoNote()
              : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SearchField(),
              if(notes.isNotEmpty)...[
              ViewOptions(),

              Expanded(
                child:notesProvider.isGridView? NotesGrid(
                  notes: notes,
                ):NotesList(
                  notes: notes,
                ),
              ),]else Expanded(
                  child: Center( 
                    child: Text(
                        "No Note's Found For Your Search Query!",
                      textAlign: TextAlign.center,
                    ),
                  )
              ),
            ],
          ),
        );
    }
      ),

    );
  }
}










