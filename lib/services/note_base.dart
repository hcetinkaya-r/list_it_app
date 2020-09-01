import 'package:list_it_app/models/note.dart';

abstract class NoteBase{
  Future<List<Map<String, dynamic>>> getNotes();
  Future<List<Note>> getNoteList();
  Future<String> addNote(Note note);
  Future<String> deleteNote(String noteID);
  Future<String> updateNote(Note note);

}