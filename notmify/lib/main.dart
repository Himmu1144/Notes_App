import 'package:flutter/material.dart';
import 'package:notmify/pages/notes_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const NotesPage();
  }
}
