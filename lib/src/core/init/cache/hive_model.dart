import 'dart:typed_data';
import 'package:hive/hive.dart';
import '../../../feature/home/model/catalog/catalog_response_model.dart';
part 'hive_model.g.dart';

@HiveType(typeId: 0)
class UserHiveDb {
  @HiveField(0)
  bool currentUser;

  @HiveField(1)
  DateTime lastSessionDate;

  @HiveField(2)
  UserDb user;

  UserHiveDb({
    required this.currentUser,
    required this.lastSessionDate,
    required this.user,
  });
}

@HiveType(typeId: 1)
class UserDb {
  @HiveField(0)
  String token;
  @HiveField(1)
  CategoryField? categoryField;

  UserDb({
    required this.token,
    this.categoryField,
  });
}

@HiveType(typeId: 2)
class CategoryField {
  @HiveField(0)
  DateTime createdDate;
  @HiveField(1)
  List<CategoryModelDb> categories;

  CategoryField({
    required this.createdDate,
    required this.categories,
  });
}

@HiveType(typeId: 3)
class CategoryModelDb {
  @HiveField(0)
  final String categoryName;
  @HiveField(1)
  final List<ProductModelDb> products;

  CategoryModelDb({
    required this.categoryName,
    required this.products,
  });

  factory CategoryModelDb.fromModel(CategoryModel category) {
    return CategoryModelDb(
      categoryName: category.categoryName,
      products: category.products
          .map((product) => ProductModelDb.fromModel(product))
          .toList(),
    );
  }

  CategoryModel toModel() {
    return CategoryModel(
      categoryName: categoryName,
      products: products.map((productDb) => productDb.toModel()).toList(),
    );
  }
}

@HiveType(typeId: 4)
class ProductModelDb {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String author;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String cover;
  @HiveField(5)
  final double price;
  @HiveField(6)
  final int sales;
  @HiveField(7)
  final String slug;
  @HiveField(8)
  int likesCount;
  @HiveField(9)
  final String url;
  @HiveField(10)
  Uint8List image;

  ProductModelDb({
    required this.id,
    required this.name,
    required this.author,
    required this.description,
    required this.cover,
    required this.price,
    required this.sales,
    required this.slug,
    required this.likesCount,
    required this.url,
    required this.image,
  });

  factory ProductModelDb.fromModel(ProductModel product) {
    return ProductModelDb(
      id: product.id,
      name: product.name,
      author: product.author,
      description: product.description,
      cover: product.cover,
      price: product.price,
      sales: product.sales,
      slug: product.slug,
      likesCount: product.likesCount,
      url: product.url,
      image: product.image,
    );
  }

  ProductModel toModel() {
    return ProductModel(
      id: id,
      name: name,
      author: author,
      description: description,
      cover: cover,
      price: price,
      sales: sales,
      slug: slug,
      likesCount: likesCount,
      url: url,
      image: image,
    );
  }
}
