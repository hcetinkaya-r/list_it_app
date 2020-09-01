import 'package:flutter/cupertino.dart';
import 'package:list_it_app/locator.dart';
import 'package:list_it_app/models/category.dart';
import 'package:list_it_app/repository/category_repository.dart';
import 'package:list_it_app/services/category_base.dart';

enum ViewState{Specified, Pinned, Deleted}

class CategoryModel with ChangeNotifier implements CategoryBase{
  CategoryRepository _categoryRepository = locator<CategoryRepository>();
  ViewState _state = ViewState.Specified;
  Category _category;

  Category get category => _category;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

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