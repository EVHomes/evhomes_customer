class CpUserModel {
  final String name;
  final String email;
  final String firm;
  final String phoneNumber;
  final String reraNumber;
  final String dataAnalyser;
  final String teamLeader;

  CpUserModel({
    required this.name,
    required this.email,
    required this.firm,
    required this.phoneNumber,
    required this.reraNumber,
    required this.dataAnalyser,
    required this.teamLeader,
  });

  factory CpUserModel.fromFirebase(Map<String, dynamic> json) {
    return CpUserModel(
      name: json["name"] ?? '',
      email: json["email"] ?? '',
      firm: json["firm"] ?? '',
      phoneNumber: json["phoneNumber"] ?? '',
      reraNumber: json["reraNumber"] ?? '',
      dataAnalyser: json["dataAnalyser"] ?? '',
      teamLeader: json["teamLeader"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "firm": firm,
      "phoneNumber": phoneNumber,
      "reraNumber": reraNumber,
      "dataAnalyser": dataAnalyser,
      "teamLeader": teamLeader,
    };
  }
}
