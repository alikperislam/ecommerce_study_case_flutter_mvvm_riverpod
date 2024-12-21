class ImageResponseModel {
  ActionProductImage? actionProductImage;

  ImageResponseModel({this.actionProductImage});

  ImageResponseModel.fromJson(Map<String, dynamic> json) {
    actionProductImage = json['action_product_image'] != null
        ? ActionProductImage.fromJson(json['action_product_image'])
        : null;
  }
}

class ActionProductImage {
  String? url;

  ActionProductImage({this.url});

  ActionProductImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }
}
