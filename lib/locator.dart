

import 'package:get_it/get_it.dart';
import 'package:list_it_app/repository/user_repository.dart';
import 'package:list_it_app/services/fake_auth_service.dart';
import 'package:list_it_app/services/firestore_db_service.dart';
import 'package:list_it_app/services/firebase_auth_service.dart';
import 'package:list_it_app/services/firebase_storage_service.dart';

GetIt locator = GetIt.instance;

void setupLocator(){

  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FakeAuthenticationService());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => FireStoreDBService());
  locator.registerLazySingleton(() => FirebaseStorageService());


}