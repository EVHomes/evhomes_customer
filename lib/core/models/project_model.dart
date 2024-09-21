import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_homes_customer/core/models/amenitiy_model.dart';
import 'package:ev_homes_customer/core/models/bhk_model.dart';

class ProjectModel {
  final String name;
  final String description;
  final String showCaseImage;
  final List<String> carouselImages;
  final List<BhkModel> bhkList;
  final List<AmenitiyModel> amenities;
  final String locationName;
  final String locationLink;

  ProjectModel({
    required this.name,
    required this.description,
    required this.showCaseImage,
    required this.carouselImages,
    required this.bhkList,
    required this.amenities,
    required this.locationName,
    required this.locationLink,
  });

  factory ProjectModel.fromFirestore(DocumentSnapshot doc) {
    final json = doc.data() as Map<String, dynamic>?;

    // Handle the case where data might be null
    if (json == null) {
      throw Exception("Document data is null");
    }

    return ProjectModel(
      name: json["name"] ?? '',
      locationName: json["locationName"] ?? '',
      locationLink: json["locationLink"] ?? '',
      description: json["description"] ?? '',
      showCaseImage: json["showCaseImage"] ?? '',
      carouselImages: List<String>.from(json["carouselImages"] ?? []),
      bhkList: (json["bhkList"] as List<dynamic>?)
              ?.map((ele) => BhkModel.fromJson(ele as Map<String, dynamic>))
              .toList() ??
          [],
      amenities: (json["amenities"] as List<dynamic>?)
              ?.map(
                  (ele) => AmenitiyModel.fromJson(ele as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      name: json["name"] ?? '',
      locationName: json["locationName"] ?? '',
      locationLink: json["locationLink"] ?? '',
      description: json["description"] ?? '',
      showCaseImage: json["showCaseImage"] ?? '',
      carouselImages: List<String>.from(json["carouselImages"] ?? []),
      bhkList: (json["bhkList"] as List<dynamic>?)
              ?.map((ele) => BhkModel.fromJson(ele as Map<String, dynamic>))
              .toList() ??
          [],
      amenities: (json["amenities"] as List<dynamic>?)
              ?.map(
                  (ele) => AmenitiyModel.fromJson(ele as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "locationName": locationName,
      "locationLink": locationLink,
      "description": description,
      "showCaseImage": showCaseImage,
      "carouselImages": carouselImages,
      "bhkList": bhkList.map((e) => e.toJson()).toList(),
      "amenities": amenities.map((e) => e.toJson()).toList(),
    };
  }
}
