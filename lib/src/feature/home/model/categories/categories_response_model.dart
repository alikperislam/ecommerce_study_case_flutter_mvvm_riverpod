class CategoriesResponseModel {
  List<Category>? category;

  CategoriesResponseModel({this.category});

  CategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
  }
}

class Category {
  int? id;
  String? name;
  String? createdAt;

  Category({this.id, this.name, this.createdAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
  }
}
