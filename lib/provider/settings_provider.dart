import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:ev_homes_customer/core/models/MeetingModel.dart';
import 'package:ev_homes_customer/core/models/onBoarding.dart';
import 'package:ev_homes_customer/core/models/project_model.dart';
import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
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

  void _fetchOnBoarding() {
    _onBoardingSubscription =
        _firestore.collection('onBoarding').snapshots().listen((snapshot) {
      _onBoarding =
          snapshot.docs.map((doc) => OnBoarding.fromFirestore(doc)).toList();
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

    super.dispose();
  }
}
