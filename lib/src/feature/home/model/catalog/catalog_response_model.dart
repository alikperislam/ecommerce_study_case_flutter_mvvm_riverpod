import 'dart:typed_data';

class ProductModel {
  final int id;
  final String name;
  final String author;
  final String description;
  final String cover;
  final double price;
  final int sales;
  final String slug;
  final int likesCount;
  final String url;
  final Uint8List image;

  ProductModel({
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

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      author: json['author'],
      description: json['description'],
      cover: json['cover'],
      price: json['price'],
      sales: json['sales'],
      slug: json['slug'],
      likesCount: json['likes_aggregate']['aggregate']['count'] ?? 0,
      url: json['url'],
      image: json['image'],
    );
  }
}

class CategoryModel {
  final String categoryName;
  final List<ProductModel> products;

  CategoryModel({
    required this.categoryName,
    required this.products,
  });
}
