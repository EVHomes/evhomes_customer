class AmenitiyModel {
  final String name;
  final String image;

  AmenitiyModel({
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "image": image,
    };
  }

  factory AmenitiyModel.fromJson(Map<String, dynamic> json) {
    return AmenitiyModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
