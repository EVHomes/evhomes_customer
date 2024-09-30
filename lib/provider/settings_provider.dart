import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_homes_customer/core/models/onBoarding.dart';
import 'package:ev_homes_customer/core/models/project_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<OnBoarding> _onBoarding = [];

  StreamSubscription? _onBoardingSubscription;
  SettingsProvider() {
    _fetchOnBoarding();
  }

  List<OnBoarding> get onBoarding => _onBoarding;

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

  @override
  void dispose() {
    // _fetchOnBoarding?.cancel();
    super.dispose();
  }
}
