import 'package:cloud_firestore/cloud_firestore.dart';

class OnBoarding {
  final String image_path;
  final String description;
  int? index;

  OnBoarding({
    required this.image_path,
    required this.description,
    this.index,
  });

  factory OnBoarding.fromFirestore(DocumentSnapshot doc) {
    final json = doc.data() as Map<String, dynamic>?;
    if (json == null) {
      throw Exception("Document data is null");
    }
    return OnBoarding(
      image_path: json["image_path"] ?? '',
      description: json["description"] ?? '',
      index: int.parse(json['index']) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "image_path": image_path,
      "description": description,
      "index": index
    };
  }
}
