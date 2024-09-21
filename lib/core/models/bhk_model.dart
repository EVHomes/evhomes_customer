class BhkModel {
  final String reraId;
  final String image;
  final String carpetArea;
  final String price;
  final String configuration;

  BhkModel({
    required this.reraId,
    required this.image,
    required this.carpetArea,
    required this.price,
    required this.configuration,
  });

  Map<String, dynamic> toJson() {
    return {
      "reraId": reraId,
      "image": image,
      "carpetArea": carpetArea,
      "price": price,
      "configuration": configuration,
    };
  }

  factory BhkModel.fromJson(Map<String, dynamic> json) {
    if (json['reraId'] == null) print("rera null");
    if (json['image'] == null) print("image null");
    if (json['carpetArea'] == null) print("carpetArea null");
    if (json['price'] == null) print("price null");
    if (json['configuration'] == null) print("configuration null");

    return BhkModel(
      reraId: json['reraId'] ?? '',
      image: json['image'] ?? '',
      carpetArea: json['carpetArea'] ?? '',
      price: json['price'] ?? '',
      configuration: json['configuration'] ?? '',
    );
  }
}
