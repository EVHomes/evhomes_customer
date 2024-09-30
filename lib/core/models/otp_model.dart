import 'package:cloud_firestore/cloud_firestore.dart';

class OtpModel {
  final String otp;
  final String reference;
  final String timeStamp;

  OtpModel(
      {required this.otp, required this.reference, required this.timeStamp});

  factory OtpModel.fromFirebase(DocumentSnapshot doc) {
    final json = doc.data() as Map<String, dynamic>?;
    if (json == null) {
      throw Exception("Document data is null");
    }
    return OtpModel(
      otp: json["otp"] ?? '',
      reference: json["reference"] ?? '',
      timeStamp: json["timestamp"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "otp": otp,
      "reference": reference,
      "timestamp": timeStamp,
    };
  }
}
