import 'package:awesome_notes/change_notifier/notes_provider.dart';
import 'package:awesome_notes/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final NotesProvider notesProvider;
  late final TextEditingController searchController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notesProvider=context.read();
    searchController=TextEditingController()..addListener(
        (){
          notesProvider.searchTerm=searchController.text;
        }
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,

      decoration: InputDecoration(
        hintText: "Search Notes....",
        hintStyle: TextStyle(
            fontSize: 12
        ),
        prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass,size: 16,),
        suffixIcon:ListenableBuilder(
            listenable: searchController,
            builder: (context,clearButton)=> searchController.text.isNotEmpty?
            clearButton! :
                SizedBox.shrink(),
          child: GestureDetector(
            child: Icon(FontAwesomeIcons.xmark),
            onTap: (){
              searchController.clear();
            },
          ),
        ),
        fillColor: white,
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.zero,
        prefixIconConstraints: BoxConstraints(
            minHeight: 42,
            minWidth: 42
        ),
        suffixIconConstraints: BoxConstraints(
            minHeight: 42,
            minWidth: 42
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: primary
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: primary
            )
        ),
      ),

    );
  }
}