import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:list_it_app/services/storage_base.dart';

class FirebaseStorageService implements StorageBase{


  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  StorageReference _storageReference;
  @override
  Future<String> uploadFile(String userId, String fileType, File fileToUpload) async {

    _storageReference = _firebaseStorage.ref().child(userId).child(fileType).child("profile_photo.png");
    var uploadTask = _storageReference.putFile(fileToUpload);

    var url = await (await uploadTask.onComplete).ref.getDownloadURL();
    return url;





  }
  
}