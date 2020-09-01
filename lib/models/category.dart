class Category{
  String categoryID;
  String categoryName;

  Category({this.categoryID, this.categoryName});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['categoryID'] = categoryID;
    map['categoryNAme'] = categoryName;
    return map;
  }

  Category.fromMap(Map<String, dynamic> map) {
    this.categoryID = map['categoryID'];
    this.categoryName = map['categoryNAme'];
  }

  @override
  String toString() {
    return 'Category{categoryID: $categoryID, categoryName: $categoryName}';
  }
}