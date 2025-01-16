import 'package:awesome_notes/change_notifier/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../enums/order_by.dart';
import '../utils/constants.dart';

class ViewOptions extends StatefulWidget {
  const ViewOptions({super.key});

  @override
  State<ViewOptions> createState() => _ViewOptionsState();
}

class _ViewOptionsState extends State<ViewOptions> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NotesProvider>(
      builder:(_,notesProvider,__)=> Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            IconButton(
              onPressed: (){
                setState(() {
                  notesProvider.isDecending= !notesProvider.isDecending;
                });
              },
              icon: FaIcon(notesProvider.isDecending?FontAwesomeIcons.arrowDown:FontAwesomeIcons.arrowUp),
              iconSize: 18,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              visualDensity: VisualDensity.compact,
              style: IconButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              color: grey700,

            ),
            SizedBox(width: 16,),

            DropdownButton<OrderOptions>(

                value: notesProvider.OrderBy,
                icon: Padding(
                  padding: const EdgeInsets.only(left:12.0),
                  child: FaIcon(
                    FontAwesomeIcons.arrowDownWideShort,
                    size: 18,
                    color: grey700,
                  ),
                ),
                underline: SizedBox.shrink(),
                borderRadius: BorderRadius.circular(16),
                items: OrderOptions.values.map(
                        (e)=>DropdownMenuItem(
                        value: e,
                        child: Row(
                          children: [
                            Text(e.name),
                            if(e==notesProvider.OrderBy) ...[
                              SizedBox(width: 8,),
                              Icon(
                                FontAwesomeIcons.check,
                                size: 18,
                              ),


                            ],
                          ],
                        ))).toList(),
                selectedItemBuilder: (context) => OrderOptions.values.map((e)=>DropdownMenuItem(child: Text(e.name))).toList(),
                onChanged: (newvalue){
                  setState(() {
                    notesProvider.OrderBy=newvalue!;
                  });
                }
            ),
            Spacer(),
            IconButton(
              onPressed: (){
                setState(() {
                  notesProvider.isGridView = !notesProvider.isGridView;
                });
              },
              icon:FaIcon(notesProvider.isGridView?FontAwesomeIcons.tableCellsLarge : FontAwesomeIcons.bars),iconSize: 18,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              visualDensity: VisualDensity.compact,
              style: IconButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              color: grey700,

            )
          ],
        ),
      ),
    );
  }
}
