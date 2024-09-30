import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String email;
  final String phone;
  final String? countryCode;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    this.countryCode = "+91",
  });

  factory UserModel.fromFirebase(DocumentSnapshot doc) {
    final json = doc.data() as Map<String, dynamic>?;
    if (json == null) {
      throw Exception("Document data is null");
    }
    return UserModel(
      name: json["name"] ?? '',
      email: json["email"] ?? '',
      phone: json["phone"] ?? '',
      countryCode: json["countryCode"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "countryCode": countryCode,
    };
  }
}
