import 'package:list_it_app/locator.dart';
import 'package:list_it_app/models/category.dart';
import 'package:list_it_app/services/category_base.dart';
import 'package:list_it_app/services/firestore_db_service.dart';

class CategoryRepository implements CategoryBase{
  FireStoreDBService _fireStoreDBService = locator<FireStoreDBService>();

  @override
  Future<String> addCategory(Category category) {
    // TODO: implement addCategory
    throw UnimplementedError();
  }

  @override
  Future<String> deleteCategory(String categoryID) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String,dynamic>>> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  Future<List<Category>> getCategoryList() {
    // TODO: implement getCategoryList
    throw UnimplementedError();
  }

  @override
  Future<String> updateCategory(Category category) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }

}