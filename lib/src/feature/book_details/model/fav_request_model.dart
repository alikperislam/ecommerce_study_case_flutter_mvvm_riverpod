class FavRequestModel {
  String? userId;
  String? productId;

  FavRequestModel({
    this.userId,
    this.productId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['user_id'] = userId;
    data['product_id'] = productId;
    return data;
  }
}
