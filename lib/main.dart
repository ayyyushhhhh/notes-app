import 'package:flutter/material.dart';
import 'package:notes_app/screens/notesList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(
              fontFamily: "San Francisco",
            ),
      ),
      home: NotesScreen(),
    );
  }
}
