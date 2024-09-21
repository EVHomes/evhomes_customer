import 'package:cloud_firestore/cloud_firestore.dart';

class ChannelPartner {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  final String dateOfBirth;
  final String gender;
  final String homeAddress;
  final bool haveReraNumber;
  final bool sameAdress;
  final String? firmAddress;
  final String? firmName;
  final String? reraNumber;
  final String? reraCertificate;
  final String assignedDataAnalyser;
  final String assignedDataAnalyserRef;
  final String assignedTeamLeader;
  final String assignedTeamLeaderRef;
  final Timestamp createdAt;

  ChannelPartner({
    required this.uid,
    required this.name,
    required this.email,
    required this.gender,
    required this.sameAdress,
    required this.phoneNumber,
    required this.homeAddress,
    required this.dateOfBirth,
    required this.haveReraNumber,
    required this.assignedTeamLeader,
    required this.assignedTeamLeaderRef,
    required this.assignedDataAnalyser,
    required this.assignedDataAnalyserRef,
    required this.createdAt,
    this.firmName = "",
    this.reraNumber = "",
    this.firmAddress = "",
    this.reraCertificate = "",
  });

  factory ChannelPartner.fromFirestore(DocumentSnapshot doc) {
    final json = doc.data() as Map<String, dynamic>?;

    // Handle the case where data might be null
    if (json == null) {
      throw Exception("Document data is null");
    }

    return ChannelPartner(
      uid: json["uid"],
      name: json["name"],
      email: json["email"],
      gender: json["gender"],
      sameAdress: json["sameAdress"] ?? false,
      phoneNumber: json["phoneNumber"] ?? '',
      homeAddress: json["homeAddress"] ?? '',
      dateOfBirth: json["dateOfBirth"] ?? '',
      haveReraNumber: json["haveReraNumber"] ?? false,
      assignedTeamLeader: json["assignedTeamLeader"] ?? '',
      assignedTeamLeaderRef: json["assignedTeamLeaderRef"] ?? '',
      assignedDataAnalyser: json["assignedDataAnalyser"] ?? '',
      assignedDataAnalyserRef: json["assignedDataAnalyserRef"] ?? '',
      firmAddress: json["firmAddress"] ?? '',
      firmName: json["firmName"] ?? '',
      reraCertificate: json["reraCertificate"] ?? '',
      reraNumber: json["reraNumber"] ?? '',
      createdAt: json['created_at'] ?? Timestamp.now(),
    );
  }
  // Method to convert UserModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'homeAddress': homeAddress,
      'haveReraNumber': haveReraNumber,
      'reraCertificate': reraCertificate,
      'reraNumber': reraNumber,
      'firmAddress': firmAddress,
      'firmName': firmName,
      'sameAdress': sameAdress,
      'dateOfBirth': dateOfBirth,
      'assignedDataAnalyser': assignedDataAnalyser,
      'assignedDataAnalyserRef': assignedDataAnalyserRef,
      'assignedTeamLeader': assignedTeamLeader,
      'assignedTeamLeaderRef': assignedTeamLeaderRef,
      'created_at': createdAt,
    };
  }
}
