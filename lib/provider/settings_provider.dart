import 'dart:async'; // for StreamSubscription
import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:ev_homes_customer/core/models/MeetingModel.dart';
import 'package:ev_homes_customer/core/models/onBoarding.dart';
import 'package:ev_homes_customer/core/models/project_model.dart';
import 'package:flutter/material.dart';

class SettingProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  List<OnBoarding> _onBoarding = [];
  List<ProjectModel> _ourProjects = [];
  //List<MeetingModel> _meeting = [];
  List<String> _places = [];
  List<String> _purposes = [];
  Map<String, String> _placeUrls = {};

  StreamSubscription? _onBoardingSubscription;
  StreamSubscription? _ourProjectsSubscription;
//  StreamSubscription? _meetingSubscription;
  StreamSubscription? _placesSubscription;
  StreamSubscription? _purposesSubscription;
  SettingsProvider() {
    _fetchOnBoarding();
    _fetchOurProjects();
    _fetchPlaces();
    _fetchPurposes();
   // fetchMeeting();
  }

  List<OnBoarding> get onBoarding => _onBoarding;
  List<ProjectModel> get ourProjects => _ourProjects;
  //List<MeetingModel> get meetings => _meeting;
  List<String> get places => _places;
  List<String> get purposes => _purposes;
  Map<String, String> get placeUrls => _placeUrls;
=======
 

  void _fetchChannelPartners() {
    _channelPartnerSubscription =
        _firestore.collection('cpDetails').snapshots().listen((snapshot) {
      _channelPartners = snapshot.docs
          .map((doc) => ChannelPartner.fromFirestore(doc))
          .toList();
      notifyListeners();
    }, onError: (error) {
      // Handle error here
    });
  }

  void _fetchOurProjects() {
    _ourProjectsSubscription =
        _firestore.collection('ourProjects').snapshots().listen((snapshot) {
      _ourProjects =
          snapshot.docs.map((doc) => ProjectModel.fromFirestore(doc)).toList();
      notifyListeners();
    }, onError: (error) {
      // Handle error here
    });
  }

  void _fetchPlaces() {
    _placesSubscription =
        _firestore.collection('place').snapshots().listen((snapshot) {
      _places = snapshot.docs.map((doc) => doc['name'] as String).toList();
      print(_places);
      _placeUrls = Map.fromEntries(snapshot.docs
          .map((doc) => MapEntry(doc['name'] as String, doc['url'] as String)));
      notifyListeners();
    }, onError: (error) {
      // Handle error here
      print('Error fetching places: $error');
    });
  }

  void _fetchPurposes() {
    _purposesSubscription =
        _firestore.collection('purpose').snapshots().listen((snapshot) {
      _purposes = snapshot.docs.map((doc) => doc['name'] as String).toList();
      notifyListeners();
    }, onError: (error) {
      // Handle error here
      print('Error fetching purposes: $error');
    });
  }

  // void fetchMeeting() {
  //   _meetingSubscription =
  //       _firestore.collection("scheduleMeeting").snapshots().listen((snapshot) {
  //     _meeting =
  //         snapshot.docs.map((doc) => MeetingModel.fromFirestore(doc)).toList();
  //     notifyListeners();
  //   }, onError: (error) {
  //     print('Error fetching purposes: $error');
  //   });
  // }

  @override
  void dispose() {
    _onBoardingSubscription?.cancel();
    _ourProjectsSubscription?.cancel();
  void _fetchLoggedUser() {
    isLoading = true; // Start by setting loading to true
    notifyListeners();

    _userSubscription = _auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        try {
          // Fetch user data from Firestore
          _user = await getUserData();
        } catch (e) {
          // Handle error (optional)
          _user = null;
        }
      } else {
        _user = null;
      }

      isLoading = false; // Loading is done after data fetch completes
      notifyListeners();
    });
  }

  Future<ChannelPartner?> getUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      print("uid ${user.uid}");
      print("$user");
      DocumentSnapshot userDoc =
          await _firestore.collection('cpDetails').doc(user.uid).get();
      if (userDoc.exists) {
        return ChannelPartner.fromFirestore(userDoc);
      }
    }
    return null;
  }

  void disposeAllOnLogout() {
    _designationSubscription?.cancel();
    _departmentSubscription?.cancel();
    _divisionSubscription?.cancel();
    _employeeSubscription?.cancel();
    _channelPartnerSubscription?.cancel();
    _ourPorjectsSubscription?.cancel();
    _userSubscription?.cancel();
    _leadsSubscription?.cancel();
    _designations = [];
    _departments = [];
    _divisions = [];
    _ourProjects = [];
    _employees = [];
    _channelPartners = [];
    // _leads = [];
    _user = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _designationSubscription?.cancel();
    _departmentSubscription?.cancel();
    _divisionSubscription?.cancel();
    _employeeSubscription?.cancel();
    _channelPartnerSubscription?.cancel();
    _ourPorjectsSubscription?.cancel();
    _userSubscription?.cancel();
    _leadsSubscription?.cancel();
    super.dispose();
  }
}
