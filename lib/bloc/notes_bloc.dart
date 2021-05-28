import 'dart:async';
import 'package:notes_app/database/database_helper.dart';
import 'package:notes_app/model/notes_model.dart';

class NotesBloc {
  final StreamController<List<Notes>> _notesStream =
      StreamController<List<Notes>>.broadcast();

  Stream<List<Notes>> get getNotesStream => _notesStream.stream;

  NotesBloc() {
    getAllNotes();
  }

  void dispose() {
    _notesStream.close();
  }

  void getAllNotes() async {
    _notesStream.add(await NotesDatabase.instance.readAllNotes());
  }

  addNewNote(Notes note) async {
    await NotesDatabase.instance.create(note);
    getAllNotes();
  }

  updateNewNote(Notes note) async {
    await NotesDatabase.instance.update(note);
    getAllNotes();
  }

  void deleteNote(int id) async {
    await NotesDatabase.instance.delete(id);
    getAllNotes();
  }
}
