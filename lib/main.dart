import 'package:flutter/material.dart';
import 'package:notes/models/note_database.dart';
import 'package:notes/pages/notes_page.dart';
import 'package:notes/pages/settings_page.dart';
import 'package:notes/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  // initializing teh note isar database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<NoteDatabase>(
          create: (context) => NoteDatabase(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NotesPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        '/settings': (context) => const SettingsPage(), // Define the route here
      },
    );
  }
}
