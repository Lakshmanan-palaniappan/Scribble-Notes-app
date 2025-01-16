import 'dart:convert';

import 'package:awesome_notes/change_notifier/notes_provider.dart';
import 'package:awesome_notes/modals/note.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

class NewNoteController extends ChangeNotifier{
  Notes? _note;
  set note(Notes? value){
    _note=value;
    _title=_note!.title ?? '';
    _content=Document.fromJson(jsonDecode(_note!.contentJson ??''));
    _tags.addAll(_note!.tags??[]);
    notifyListeners();
  }
  Notes?get note=>_note;
  bool get isNewnote=>_note==null;

  bool _readOnly=false;
  set readOnly(bool value){
    _readOnly=value;
    notifyListeners();
  }
  bool get readOnly=> _readOnly;
  String _title='';
  set title(String value){
    _title=value;
    notifyListeners();
  }
  String get title=>_title;
  Document _content=Document();
  set content(Document value){
    _content=value;
    notifyListeners();
  }
  Document get content=>_content;

  List<String> _tags=[];
  void addTags(String tag){
    _tags.add(tag);
    notifyListeners();
  }
  List<String> get tags=>[..._tags];
  bool get canSaveNote{
    final String? newTitle=title.isNotEmpty?title:null;
    final String? newContent=content.toPlainText().trim().isNotEmpty?content.toPlainText().trim():null;
    if(isNewnote) {
      return newTitle != null || newContent != null;
    }else{
      final newContentjson=jsonEncode(content.toDelta().toJson());
      return (
          newTitle!=note!.title
              ||newContentjson!=note!.contentJson
              || !listEquals(tags,note!.tags))&&(newTitle != null || newContent != null);

    }
  }

  void removeTag(int index){
    _tags.removeAt(index);
    notifyListeners();
  }
  void saveNote(BuildContext context){
    final String? newTitle=title.isNotEmpty?title:null;
    final String? newContent=content.toPlainText().trim().isNotEmpty?content.toPlainText().trim():null;
    final String contentJson=jsonEncode(_content.toDelta().toJson());
    final int now=DateTime.now().microsecondsSinceEpoch;
    final Notes note=Notes(
        title: newTitle,
        content: newContent,
        contentJson: contentJson,
        tags: tags,
        dateCreated: isNewnote?now:_note!.dateCreated,
        dateModified: now
    );
    final notesProvider=context.read<NotesProvider>();
    isNewnote?notesProvider.addNote(note):notesProvider.updateNote(note);

  }
  // void remove(BuildContext context,int index){
  //   context.read<NotesProvider>().removeNote(index);
  //
  // }
  void updateTag(String tag,int index){
    _tags[index]=tag;
    notifyListeners();
  }

}