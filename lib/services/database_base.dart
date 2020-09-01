import 'package:list_it_app/models/app_user.dart';
import 'package:list_it_app/models/note.dart';



abstract class DBBase{

  Future<bool> saveUser(AppUser appUser);
  Future<AppUser> readUser(String userID);
  Future<bool> updateUserName(String userID, String newUserName);
  Future<bool> updateProfilePhoto(String userID, String profileURL);
  Future<bool> saveNote(Note note);
  Future<Note> readNote(String noteID);
  Future<bool> deleteNote(String noteID);
  Future<Note> addNote(String noteID, String noteTitle, String noteContent);
  Future<bool> updateNote(String noteID, String newNoteTitle, String newNoteContent);






}