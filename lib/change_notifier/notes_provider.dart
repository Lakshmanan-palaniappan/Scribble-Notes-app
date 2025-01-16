import 'package:flutter/material.dart';

import '../enums/order_by.dart';
import '../modals/note.dart';

extension ListDeepContains on List<String>{
  bool deepContains(String term){
    return contains(term) || any((element)=> element.contains(term));
  }

}

class NotesProvider extends ChangeNotifier{
  final List<Notes> _notes=[];
  List<Notes> get notes =>[..._searchTerm.isEmpty?_notes: _notes.where(_test)]..sort(_Compare);
  int _Compare(Notes note1,note2){
    return _orderby==
        OrderOptions.dateModified ? _isDecending?
    note2.dateModified.compareTo(note1.dateModified): note1.dateModified.compareTo(note2.dateModified)
        : _isDecending? note2.dateCreated.compareTo(note1.dateCreated):note1.dateCreated.compareTo(note2.dateCreated);
  }
  bool _test(Notes note){
    final term = _searchTerm.toLowerCase().trim();
    final title=note.title?.toLowerCase()??'';
    final content =note.content?.toLowerCase()??'';
    final tags=note.tags?.map((e)=>e.toLowerCase()).toList()??[];
    return title.contains(term) || content.contains(term) || tags.deepContains(term);

  }
  void addNote(Notes note){
    _notes.add(note);
    notifyListeners();
  }
  void removeNote(Notes note){
    _notes.remove(note);
    notifyListeners();
  }
  void updateNote(Notes note){
    final index=_notes.indexWhere((element)=> element.dateCreated==note.dateCreated);
    _notes[index]=note;
    notifyListeners();
  }

  OrderOptions _orderby=OrderOptions.dateModified;
  set OrderBy(OrderOptions value){
    _orderby=value;
    notifyListeners();
  }
  OrderOptions get OrderBy=>_orderby;
  bool _isDecending=true;
  set isDecending(bool value){
    _isDecending=value;
    notifyListeners();
  }
  bool get isDecending=>_isDecending;
  bool _isGridview=true;
  set isGridView(bool value){
    _isGridview=value;
    notifyListeners();
  }
  bool get isGridView=>_isGridview;

  String _searchTerm='';
  set searchTerm(String value){
    _searchTerm=value;
    notifyListeners();
  }
  String get searchTerm=>_searchTerm;

}
