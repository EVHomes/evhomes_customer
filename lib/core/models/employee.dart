import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  final String employeeId;
  final String uid;

  final String name;
  final String email;
  final String phoneNumber;
  final String dateOfBirth;
  final String gender;
  final String address;
  final String designation;
  final String department;
  final String division;
  final String reportingTo;
  final String reportingToRef;
  final Timestamp createdAt;

  Employee({
    required this.name,
    required this.email,
    required this.uid,
    required this.gender,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.createdAt,
    required this.employeeId,
    required this.address,
    required this.department,
    required this.designation,
    required this.division,
    required this.reportingTo,
    required this.reportingToRef,
  });
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Employee && other.employeeId == employeeId;
  }

  @override
  int get hashCode => employeeId.hashCode;

  factory Employee.fromFirestore(DocumentSnapshot doc) {
    final json = doc.data() as Map<String, dynamic>?;

    // Handle the case where data might be null
    if (json == null) {
      throw Exception("Document data is null");
    }

    return Employee(
      employeeId: json["employeeId"] ?? '',
      uid: json["uid"] ?? '',
      name: json["name"] ?? '',
      email: json["email"] ?? '',
      gender: json["gender"] ?? '',
      address: json["address"] ?? '',
      division: json["division"] ?? '',
      department: json["department"] ?? '',
      reportingTo: json["reportingTo"] ?? '',
      designation: json["designation"] ?? '',
      phoneNumber: json["phoneNumber"] ?? '',
      dateOfBirth: json["dateOfBirth"] ?? '',
      reportingToRef: json["reportingToRef"] ?? '',
      createdAt: json['created_at'] ?? Timestamp.now(),
    );
  }
  // Method to convert UserModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'employeeId': employeeId,
      'uid': uid,
      'name': name,
      'email': email,
      'gender': gender,
      'address': address,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'created_at': createdAt,
      'department': department,
      'division': division,
      'designation': designation,
      'reportingTo': reportingTo,
      'reportingToRef': reportingToRef,
    };
  }
}
