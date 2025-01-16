import 'package:awesome_notes/change_notifier/new_note_controller.dart';
import 'package:awesome_notes/components/newnote_dialog.dart';
import 'package:awesome_notes/components/note_button.dart';
import 'package:awesome_notes/components/note_metadata.dart';
import 'package:awesome_notes/components/note_tag.dart';
import 'package:awesome_notes/utils/constants.dart';
import 'package:awesome_notes/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../components/back_button.dart';
import '../components/confirmation_dialog.dart';
import '../components/dialog_card.dart';

class Newnote extends StatefulWidget {
  final bool isNewnote;
  const Newnote({super.key,required this.isNewnote});

  @override
  State<Newnote> createState() => _NewnoteState();
}

class _NewnoteState extends State<Newnote> {

  late final NewNoteController newNoteController;
  late FocusNode focusNode;
  late final QuillController quillController;
  late final TextEditingController titleController;

  @override
  void initState() {
    // TODO: implement initState
    newNoteController=context.read<NewNoteController>();
    titleController=TextEditingController(text: newNoteController.title);
    quillController = QuillController.basic()..addListener((){
      newNoteController.content=quillController.document;
    });
    super.initState();
    focusNode=FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      if(widget.isNewnote){
        focusNode.requestFocus();
        newNoteController.readOnly=false;
      }
      else{
        newNoteController.readOnly=true;
        quillController.document=newNoteController.content;
        //focusNode.unfocus();
      }

    });

    //_controller.readOnly=false;

  }
  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    quillController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop)async{
        if(didPop){
          return;
        }
        if(!newNoteController.canSaveNote) {
          Navigator.pop(context);
          return;
        }
        final bool? shouldSave=await showConfirmationDialog(
            context: context,
          title: "Do You Want To Save The Note?"
        );
        if(shouldSave==null) return;
        if(!context.mounted) return;
        if(shouldSave){
          newNoteController.saveNote(context);
        }
        Navigator.pop(context);

      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.isNewnote? "New Note" : "Edit Note"),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: NoteBackButton(),
          actions: [
            Selector<NewNoteController,bool>(
              selector: (context,newNoteController)=>newNoteController.readOnly,
              builder: (context,readOnly,child) =>IconButton(
                onPressed: (){
                  newNoteController.readOnly=!readOnly;
                  if(newNoteController.readOnly){
                    FocusScope.of(context).unfocus();
                    //focusNode.unfocus();
                  }
                  else{
                    //FocusScope.of(context).requestFocus();
                    focusNode.requestFocus();
                  }
                },
                  icon:Icon(
                      readOnly?FontAwesomeIcons.pen:FontAwesomeIcons.bookOpen
                  ),
                style: IconButton.styleFrom(
                  backgroundColor: primary,
                  foregroundColor: white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  side: BorderSide(
                    color: black
                  ),
                  iconSize: 20
                ),
              ),
            ),
            Selector<NewNoteController,bool>(
              selector: (_,newNoteController)=>newNoteController.canSaveNote,

              builder:(_,canSaveNote,__)=> IconButton(
                onPressed: canSaveNote?(){
                  newNoteController.saveNote(context);
                  Navigator.pop(context);
                }:null,
                  icon: Icon(
                      FontAwesomeIcons.check,

                  ),
                style: IconButton.styleFrom(
                  backgroundColor: primary,
                  foregroundColor: white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),

                  ),
                  side: BorderSide(
                    color: black
                  ),
                ),
                iconSize: 20,
              ),
            ),
            SizedBox(width: 10,)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Selector<NewNoteController,bool>(
                selector: (context,controller)=> controller.readOnly,

                builder:(context,readOnly,child)=> TextField(
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                  canRequestFocus: !readOnly,
                  controller: titleController,
                  onChanged: (newValue){
                    newNoteController.title=newValue;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: grey300
                    ),
                    hintText: "Title Here...",

                  ),
                ),
              ),
              NoteMetaData(note:newNoteController.note,isNewnote: widget.isNewnote),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:8.0),
                child: Divider(
                  color: grey500,
                  thickness: 2,
                ),
              ),
              Expanded(
                child: Selector<NewNoteController,bool>(
                  selector: (_,controller)=>controller.readOnly,
                  builder:(_,readOnly,__)=> Column(
                    children: [
                      Expanded(
                        child: IgnorePointer(
                          ignoring: readOnly,
                          child: QuillEditor.basic(

                            controller: quillController,
                            configurations: QuillEditorConfigurations(
                              placeholder: 'Notes Here....',
                              expands: true,




                            ),

                            focusNode: focusNode,
                          ),
                        ),
                      ),
                      if(!readOnly)
                      ...[Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),

                          color: white,
                          border: Border.all(
                            color: primary,
                            strokeAlign: BorderSide.strokeAlignOutside,

                          ),
                          boxShadow: [BoxShadow(
                            color: primary,
                            offset: Offset(4, 4)
                          )],
                        ),
                        child: QuillSimpleToolbar(
                          controller: quillController,
                            configurations: QuillSimpleToolbarConfigurations(
                              multiRowsDisplay: false,
                              showSubscript: false,
                              showSuperscript: false,
                              showSmallButton: false,
                              showInlineCode: false,
                              showAlignmentButtons: false,
                              showDirection: false,
                              showDividers: false,
                              showHeaderStyle: false,
                              showListCheck: false,
                              showCodeBlock: false,
                              showQuote: false,
                              showIndent: false,
                              showLink: false,
                              buttonOptions: QuillSimpleToolbarButtonOptions(
                                undoHistory: QuillToolbarHistoryButtonOptions(

                                  iconSize: 18,
                                  iconData: FontAwesomeIcons.arrowRotateLeft
                                ),
                                  redoHistory: QuillToolbarHistoryButtonOptions(

                                      iconSize: 18,
                                      iconData: FontAwesomeIcons.arrowRotateRight
                                  ),
                                bold: QuillToolbarToggleStyleButtonOptions(
                                  iconData: FontAwesomeIcons.bold,
                                  iconSize: 18
                                ),
                                italic: QuillToolbarToggleStyleButtonOptions(
                                    iconData: FontAwesomeIcons.italic,
                                    iconSize: 18
                                ),
                                fontSize: QuillToolbarFontSizeButtonOptions(
                                  iconSize: 14
                                ),
                                underLine: QuillToolbarToggleStyleButtonOptions(
                                    iconData: FontAwesomeIcons.underline,
                                    iconSize: 18
                                ),
                                strikeThrough: QuillToolbarToggleStyleButtonOptions(
                                    iconData: FontAwesomeIcons.strikethrough,
                                    iconSize: 18
                                ),
                                search: QuillToolbarSearchButtonOptions(
                                  iconData: FontAwesomeIcons.magnifyingGlass
                                ),
                                color: QuillToolbarColorButtonOptions(
                                  iconData: FontAwesomeIcons.palette,
                                  iconSize: 18
                                ),
                                backgroundColor: QuillToolbarColorButtonOptions(
                                  iconSize: 18,
                                  iconData: FontAwesomeIcons.fillDrip
                                ),
                                clearFormat: QuillToolbarClearFormatButtonOptions(
                                  iconData: FontAwesomeIcons.textSlash,
                                  iconSize: 18
                                ),
                                listNumbers: QuillToolbarToggleStyleButtonOptions(
                                  iconSize: 18,
                                  iconData: FontAwesomeIcons.listOl
                                ),
                                  listBullets: QuillToolbarToggleStyleButtonOptions(
                                      iconSize: 18,
                                      iconData: FontAwesomeIcons.listUl
                                  ),
                                clipboardCut: QuillToolbarToggleStyleButtonOptions(
                                  iconData: FontAwesomeIcons.scissors,
                                  iconSize: 18
                                ),
                                clipboardCopy: QuillToolbarToggleStyleButtonOptions(
                                    iconData: FontAwesomeIcons.copy,
                                    iconSize: 18
                                ),
                                clipboardPaste: QuillToolbarToggleStyleButtonOptions(
                                    iconData: FontAwesomeIcons.paste,
                                    iconSize: 18
                                ),
                              )
                            )
                        ),
                      )],
                    ],
                  ),
                ),
              )

              // Quill Editor



            ],
          ),
        ),
      ),
    );
  }
}






