import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'newnote_dialog.dart';

class DialogCard extends StatelessWidget {
  const DialogCard({
    super.key,
    required this.child
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          margin: MediaQuery.viewInsetsOf(context),
          width: MediaQuery.sizeOf(context).width*0.75,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
              color: white,
              border: Border.all(width: 2,color: black),
              boxShadow: [
                BoxShadow(
                  //color: black,
                    offset: Offset(4, 4)
                )
              ],
              borderRadius: BorderRadius.circular(16)
          ),
          child: child,
        ),
      ),
    );
  }
}

