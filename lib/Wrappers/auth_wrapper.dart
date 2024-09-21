
import 'package:ev_homes_customer/Wrappers/home_wrapper.dart';
import 'package:ev_homes_customer/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          // If the user is logged in, show the home page
          return const HomeWrapper();
        } else {
          // If the user is not logged in, show the auth page
          return LoginScreen();
        }
      },
    );
  }
}
