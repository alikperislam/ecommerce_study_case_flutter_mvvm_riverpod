class ProductsResponseModel {
  List<Product>? product;

  ProductsResponseModel({this.product});

  ProductsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
  }
}

class Product {
  String? author;
  String? cover;
  String? createdAt;
  String? description;
  int? id;
  String? name;
  double? price;
  int? sales;
  String? slug;
  LikesAggregate? likesAggregate;

  Product(
      {this.author,
      this.cover,
      this.createdAt,
      this.description,
      this.id,
      this.name,
      this.price,
      this.sales,
      this.slug,
      this.likesAggregate});

  Product.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    cover = json['cover'];
    createdAt = json['created_at'];
    description = json['description'];
    id = json['id'];
    name = json['name'];
    price = json['price'] != null
        ? (json['price'] is int
            ? (json['price'] as int).toDouble()
            : json['price'] as double)
        : null;
    sales = json['sales'];
    slug = json['slug'];
    likesAggregate = json['likes_aggregate'] != null
        ? LikesAggregate.fromJson(json['likes_aggregate'])
        : null;
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'author': author,
      'createdAt': createdAt,
      'description': description,
      'cover': cover,
      'price': price,
      'sales': sales,
      'slug': slug,
      'likes_aggregate': likesAggregate?.toJson(),
    };
  }
}

extension LikesAggregateExtension on LikesAggregate {
  Map<String, dynamic> toJson() {
    return {
      'aggregate': aggregate?.toJson(),
    };
  }
}

extension AggregateExtension on Aggregate {
  Map<String, dynamic> toJson() {
    return {
      'count': count,
    };
  }
}

class LikesAggregate {
  Aggregate? aggregate;

  LikesAggregate({this.aggregate});

  LikesAggregate.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? Aggregate.fromJson(json['aggregate'])
        : null;
  }
}

class Aggregate {
  int? count;

  Aggregate({this.count});

  Aggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }
}
