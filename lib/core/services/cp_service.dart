import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_homes_customer/core/models/channel_partner.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CpService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Future<ChannelPartner?> getUserData() async {
    User? user = currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('cpDetails').doc(user.uid).get();
      if (userDoc.exists) {
        return ChannelPartner.fromFirestore(userDoc);
      }
    }
    return null;
  }

  Future<void> createnewChannelPartner(
    String email,
    String password,
    String name,
    String gender,
    bool sameAdress,
    String homeAddress,
    String firmAddress,
    String phoneNumber,
    String dateOfBirth,
    bool haveReraNumber,
    String assignedDataAnalyser,
    String assignedTeamLeader,
    String assignedDataAnalyserRef,
    String assignedTeamLeaderRef,
  ) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = userCredential.user!.uid;
      DateTime createdAt = userCredential.user!.metadata.creationTime!;

      ChannelPartner newChannelPartner = ChannelPartner(
        uid: uid,
        name: name,
        email: email,
        gender: gender,
        sameAdress: sameAdress,
        phoneNumber: phoneNumber,
        homeAddress: homeAddress,
        dateOfBirth: dateOfBirth,
        haveReraNumber: haveReraNumber,
        assignedTeamLeader: assignedTeamLeader,
        assignedDataAnalyser: assignedDataAnalyser,
        assignedDataAnalyserRef: assignedDataAnalyserRef,
        assignedTeamLeaderRef: assignedTeamLeaderRef,
        createdAt: Timestamp.fromDate(createdAt),
      );
      await _firestore
          .collection('cpDetails')
          .doc(uid)
          .set(newChannelPartner.toMap());
      print('CP created and data saved successfully. UID: $uid');
    } catch (e) {
      print('Error creating cp: $e');
    }
  }
}
