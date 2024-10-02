import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_homes_customer/core/models/meeting_model.dart';
import 'package:ev_homes_customer/core/models/user_model.dart';

class Dataprovider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference meetingCollection =
      FirebaseFirestore.instance.collection("meeting");

//check whether phone no exists or not
  Future<bool> checkPhoneNumberExists(String phone) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot result = await firestore
        .collection('users')
        .where('phone', isEqualTo: phone)
        .limit(1)
        .get();

    final List<DocumentSnapshot> documents = result.docs;

    // If the list is not empty, it means the phone number exists
    return documents.isNotEmpty;
  }

//signing up
  Future<void> signUpUser(UserModel user) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users.add(user.toJson());
      print('User added successfully');
    } catch (e) {
      print('Error saving user data: $e');
    }
  }


//storing meeting details
  Future<void> storeMeetingData(MeetingModel meeting) async {
    try {
      CollectionReference meetings =
          FirebaseFirestore.instance.collection('meetings');
      await meetings.add(meeting.toJson());
      print("Meeting scheduled successfully");
    } catch (e) {
      print("Error sending request:$e");
    }
  }

  //delete otp from db
  Future<void> deleteOtpFromDatabase(String otpId) async {
    // Get a reference to the Firestore database
    final CollectionReference otpCollection =
        FirebaseFirestore.instance.collection('otps');

    try {
      // Delete the OTP from Firestore using the document ID
      await otpCollection.doc(otpId).delete();
      print('OTP deleted successfully from Firestore!');
    } catch (e) {
      print('Error deleting OTP from Firestore: $e');
    }
  }

  //schedule meeting

  // Future<void> getImageURL() async {
  //   final ref = storage.ref.child();
  // }
}
// class Dataprovider extends ChangeNotifier {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   final List<OtpVerificationPage> _otpList = [];
//   StreamSubscription? otp;

//   //List<OtpVerificationPage> get _otpList => _otpList;
// }
