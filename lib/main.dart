import 'package:awesome_notes/Pages/newNote.dart';
import 'package:awesome_notes/Pages/registrstion_page.dart';
import 'package:awesome_notes/change_notifier/notes_provider.dart';
import 'package:awesome_notes/services/authService.dart';
import 'package:awesome_notes/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'change_notifier/registration_controller.dart';
import 'firebase_options.dart';

import 'Pages/homepage.dart';

Future<void>main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
      create: (context)=>NotesProvider(),
    ),
    ChangeNotifierProvider(
    create: (context)=>RegistrationController()
    )
    ],
      child: MaterialApp(
        title: 'Awesome Notes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primary),
          useMaterial3: true,
          scaffoldBackgroundColor: background,
          fontFamily: 'Poppins',
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
            backgroundColor: Colors.transparent,
            titleTextStyle: TextStyle(
              fontSize: 32,
              color: primary,
              fontFamily: 'Fredoka',
              fontWeight: FontWeight.bold
            )
          )
        ),
        home: StreamBuilder<User?>(
          stream: AuthService.userStream,
          builder: (context, snapshot) {
            return snapshot.hasData && AuthService.isemailVerified
                ? HomePage():RegistrstionPage();
          }
        ),
      ),
    );
  }
}

