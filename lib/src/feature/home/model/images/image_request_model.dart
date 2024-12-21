class ImageRequestModel {
  String? fileName;
  ImageRequestModel({
    this.fileName,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['fileName'] = fileName;
    return data;
  }
}
