import 'package:get_it/get_it.dart';
import 'package:list_it_app/repository/user_repository.dart';
import 'package:list_it_app/services/budget/category_icon_service.dart';
import 'package:list_it_app/services/budget/moor_database_service.dart';
import 'package:list_it_app/services/fake_auth_service.dart';
import 'package:list_it_app/services/firebase/firestore_db_service.dart';
import 'package:list_it_app/services/firebase/firebase_auth_service.dart';
import 'package:list_it_app/services/firebase/firebase_storage_service.dart';
import 'package:list_it_app/view_models/budget/details_model.dart';
import 'package:list_it_app/view_models/budget/edit_model.dart';
import 'package:list_it_app/view_models/budget/home_model.dart';
import 'package:list_it_app/view_models/budget/insert_transaction_model.dart';
import 'package:list_it_app/view_models/budget/new_transcation_model.dart';
import 'package:list_it_app/view_models/budget/piechart_model.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
//USER FIREBASE AUTH AND DB
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FakeAuthenticationService());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => FireStoreDBService());
  locator.registerLazySingleton(() => FirebaseStorageService());

  //BUDGET SERVICES
  locator.registerLazySingleton(() => CategoryIconService());
  locator.registerLazySingleton(() => MoorDatabaseService());
  //BUDGET VIEW MODELS
  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => DetailsModel());
  locator.registerFactory(() => EditModel());
  locator.registerFactory(() => NewTransactionModel());
  locator.registerFactory(() => InsertTransactionModel());
  locator.registerFactory(() => PieChartModel());



}