import 'package:flutter/cupertino.dart';
import 'package:list_it_app/locator.dart';
import 'package:list_it_app/models/note.dart';
import 'package:list_it_app/repository/note_repository.dart';
import 'package:list_it_app/services/note_base.dart';

enum ViewState{Specified, Pinned, Deleted}

class NoteModel with ChangeNotifier implements NoteBase{
  NoteRepository _noteRepository = locator<NoteRepository>();
  ViewState _state = ViewState.Specified;
  Note _note;

  Note get note => _note;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

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