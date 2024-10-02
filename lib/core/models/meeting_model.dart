import 'package:cloud_firestore/cloud_firestore.dart';

class MeetingModel {
  final String date;
  final String place;
  final String purpose;

  MeetingModel({
    required this.date,
    required this.place,
    required this.purpose,
  });

  factory MeetingModel.fromFirestore(DocumentSnapshot doc) {
    final json = doc.data() as Map<String, dynamic>?;
    if (json == null) {
      throw Exception("Document data is null");
    }
    return MeetingModel(
      date: json["date"] ?? '',
      place: json["place"] ?? '',
      purpose: json["purpose"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "place": place,
      "purpose":purpose,
    };
  }
}
