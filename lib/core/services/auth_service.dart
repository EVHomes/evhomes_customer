import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // SignUp User
  Future<String> signupUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        // Register user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // Add user to your firestore database
        await _firestore.collection("users").doc(cred.user!.uid).set({
          'uid': cred.user!.uid,
          'email': email,
        });
        res = "success";
      } else {
        res = "Please enter all fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        res = "This email is already in use. Please try another one.";
      } else if (e.code == 'invalid-email') {
        res = "The email address is not valid. Please enter a valid email.";
      } else if (e.code == 'weak-password') {
        res = "The password is too weak. Please choose a stronger password.";
      } else {
        res = e.message.toString();
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // // LogIn user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        // Check if email exists in clientInfo collection
        var userQuery = await FirebaseFirestore.instance
            .collection('cpDetails')
            .where('email', isEqualTo: email)
            .get();

        if (userQuery.docs.isEmpty) {
          return "No user found with this email. Please check and try again.";
        }

        // If email exists, proceed with login
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        res = "Incorrect password. Please try again.";
      } else if (e.code == 'invalid-email') {
        res = "The email address is not valid. Please enter a valid email.";
      } else {
        res = e.message.toString();
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Future<String> loginUser({
  //   required String email,
  //   required String password,
  // }) async {
  //   String res = "Some error occurred";
  //   try {
  //     if (email.isNotEmpty && password.isNotEmpty) {
  //       // Logging in user with email and password
  //       await _auth.signInWithEmailAndPassword(
  //         email: email,
  //         password: password,
  //       );
  //       res = "success";
  //     } else {
  //       res = "Please enter all the fields";
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       res = "No user found with this email. Please check and try again.";
  //     } else if (e.code == 'wrong-password') {
  //       res = "Incorrect password. Please try again.";
  //     } else if (e.code == 'invalid-email') {
  //       res = "The email address is not valid. Please enter a valid email.";
  //     } else {
  //       res = e.message.toString();
  //     }
  //   } catch (err) {
  //     res = err.toString();
  //   }
  //   return res;
  // }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
