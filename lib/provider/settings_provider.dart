import 'dart:async'; // for StreamSubscription
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_homes_customer/core/models/channel_partner.dart';
import 'package:ev_homes_customer/core/models/employee.dart';
import 'package:ev_homes_customer/core/models/project_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<String> _designations = [];
  List<String> _departments = [];
  List<String> _divisions = [];
  List<ProjectModel> _ourProjects = [];
  List<Employee> _employees = [];
  List<ChannelPartner> _channelPartners = [];
  ChannelPartner? _user;
  bool isLoading = false;

  StreamSubscription? _designationSubscription;
  StreamSubscription? _departmentSubscription;
  StreamSubscription? _divisionSubscription;
  StreamSubscription? _employeeSubscription;
  StreamSubscription? _channelPartnerSubscription;
  StreamSubscription? _ourPorjectsSubscription;
  StreamSubscription? _userSubscription;
  StreamSubscription? _leadsSubscription;

  SettingProvider() {
    _fetchDesignations();
    _fetchDepartments();
    _fetchDivisions();
    _fetchEmployees();
    _fetchChannelPartners();
    _fetchLoggedUser();
    _fetchOutProjects();
    // _fetchLeads();
  }

  List<String> get designations => _designations;
  List<String> get departments => _departments;
  List<String> get divisions => _divisions;
  List<ProjectModel> get ourProjects => _ourProjects;
  List<ChannelPartner> get channelPartners => _channelPartners;
  ChannelPartner? get loggedUser => _user;
  List<Employee> get employees => _employees;

  void _fetchDesignations() {
    _designationSubscription =
        _firestore.collection('designations').snapshots().listen((snapshot) {
      _designations = snapshot.docs
          .map((doc) => doc.data()['designation'] as String)
          .toList();
      notifyListeners();
    }, onError: (error) {
      // Handle error here, like logging
    });
  }

  // void _fetchLeads() {
  //   _leadsSubscription =
  //       _firestore.collection('leads').snapshots().listen((snapshot) {
  //     final allL
  //     _leads = allLeads.where((ele) => ele.cpRefrenceId == _user!.uid).toList();

  //     notifyListeners();
  //   }, onError: (error) {
  //     // Handle error here, like logging
  //   });
  // }

  void _fetchDepartments() {
    _departmentSubscription =
        _firestore.collection('departments').snapshots().listen((snapshot) {
      _departments = snapshot.docs
          .map((doc) => doc.data()['department'] as String)
          .toList();
      notifyListeners();
    }, onError: (error) {
      // Handle error here
    });
  }

  void _fetchOutProjects() {
    _ourPorjectsSubscription =
        _firestore.collection('ourProjects').snapshots().listen((snapshot) {
      _ourProjects =
          snapshot.docs.map((doc) => ProjectModel.fromFirestore(doc)).toList();
      notifyListeners();
    }, onError: (error) {
      // Handle error here
    });
  }

  void _fetchDivisions() {
    _divisionSubscription =
        _firestore.collection('divisions').snapshots().listen((snapshot) {
      _divisions =
          snapshot.docs.map((doc) => doc.data()['division'] as String).toList();
      notifyListeners();
    }, onError: (error) {
      // Handle error here
    });
  }

  void _fetchEmployees() {
    _employeeSubscription =
        _firestore.collection('employees').snapshots().listen((snapshot) {
      _employees =
          snapshot.docs.map((doc) => Employee.fromFirestore(doc)).toList();
      notifyListeners();
    }, onError: (error) {
      // Handle error here
    });
  }

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
