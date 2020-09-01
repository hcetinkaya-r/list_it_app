import 'package:list_it_app/locator.dart';
import 'package:list_it_app/models/note.dart';
import 'package:list_it_app/services/firestore_db_service.dart';
import 'package:list_it_app/services/note_base.dart';



class NoteRepository implements NoteBase{
  FireStoreDBService _fireStoreDBService = locator<FireStoreDBService>();


  @override
  Future<String> addNote(Note note) {
    // TODO: implement addNote
    throw UnimplementedError();
  }

  @override
  Future<String> deleteNote(String noteID) {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<List<Note>> getNoteList() {
    // TODO: implement getNoteList
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String,dynamic>>> getNotes() {
    // TODO: implement getNotes
    throw UnimplementedError();
  }

  @override
  Future<String> updateNote(Note note) {
    // TODO: implement updateNote
    throw UnimplementedError();
  }









}