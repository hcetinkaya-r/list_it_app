import 'package:list_it_app/models/category.dart';

abstract class CategoryBase{
  Future<List<Map<String,dynamic>>> getCategories();
  Future<List<Category>> getCategoryList();
  Future<String> addCategory(Category category);
  Future<String> deleteCategory(String categoryID);
  Future<String> updateCategory(Category category);

}