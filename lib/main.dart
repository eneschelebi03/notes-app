import 'package:flutter/material.dart';
import 'package:mp_project/screens/notes_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      home: NotesScreen(),
    );
  }
}
