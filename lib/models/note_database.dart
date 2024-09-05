import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notes/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  // Initializing the DataBase
  static Future<void> initialize() async {
    // get the dir
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  // list of notes
  final List<Note> currentNotes = [];

  // Create
  Future<void> addNote(textFromUser) async {
    // create a note object
    final newNote = Note()..text = textFromUser;

    // saving it to isar db
    await isar.writeTxn(() => isar.notes.put(newNote));

    // re-read notes
    fetchNotes();
  }

  // Read
  Future<void> fetchNotes() async {
    final List<Note> fetchedNotes = await isar.notes.where().findAll();

    // here we'll clear out currentNodes list and add the fetched notes there
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  // Update
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  // Delete
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}
