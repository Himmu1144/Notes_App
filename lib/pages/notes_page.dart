import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:isar/isar.dart';
import 'package:notes/components/my_drawer.dart';
import 'package:notes/components/note_tile.dart';
// import 'package:notes/main.dart';
import 'package:notes/models/note.dart';
import 'package:notes/models/note_database.dart';
// import 'package:notes/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    readNotes();
  }

  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12), // Adjust this value as needed
              ),
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    context.read<NoteDatabase>().addNote(textController.text);
                    textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Create'),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ));
  }

  // read
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  // update

  void updateNote(Note note) {
    // pre-fill the text controller
    textController.text = note.text;

    // show the dialogue box
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12), // Adjust this value as needed
              ),
              title: const Text(
                'Update Note',
                style: TextStyle(fontSize: 20),
              ),
              content: TextField(
                controller: textController,
              ),
              actions: [
                // update btn
                MaterialButton(
                  onPressed: () {
                    context
                        .read<NoteDatabase>()
                        .updateNote(note.id, textController.text);
                    // clear textfield
                    textController.clear();
                    // poping the navigator
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                )
              ],
            ));
  }

  // delete a note
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();

    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        // title: const Center(
        //     child: Text(
        //   'Notes',
        //   style: TextStyle(color: Colors.white),
        // )),
        // backgroundColor: Colors.blue,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(), // Ensures the button is circular
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              'Notes',
              style: GoogleFonts.dmSerifText(
                  fontSize: 40,
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: currentNotes.length,
                itemBuilder: (context, index) {
                  final note = currentNotes[index];
                  return NoteTile(
                    text: note.text,
                    onEditPressed: () => updateNote(note),
                    ondeletePressed: () => deleteNote(note.id),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
