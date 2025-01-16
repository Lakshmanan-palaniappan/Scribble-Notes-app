import 'package:flutter/material.dart';

import '../utils/constants.dart';

class NoNote extends StatelessWidget {
  const NoNote({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/Person.png',
          width: MediaQuery.of(context).size.width*0.75,
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'You Have No Notes Yet\nStart Creating Notes Now By Clicking The + button below!',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                color: grey900,
                fontWeight: FontWeight.bold

            ),
          ),
        )
      ],
    );
  }
}