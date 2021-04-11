import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wonderwall_app/models/currUser.dart';
import 'package:wonderwall_app/screens/home.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
User loggedInUser;

class PhoneAuthService {
  bool isSignedIn = false;

  Future<dynamic> login(
      BuildContext context, phone, pin, verificationCode) async {
    try {
      await _auth
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: verificationCode, smsCode: pin))
          .then((value) async {
        if (value.user != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              (route) => false);
        }
      });
    } catch (e) {
      print("Invalid OTP");
    }
    final UserCredential userCredential = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationCode, smsCode: pin));
    final User user = userCredential.user;
    loggedInUser = user;
    print(loggedInUser.uid);
    return user;
  }

  void signOut() async {
    await _auth.signOut();
    print("Sign Out Successfully");
    isSignedIn = false;
  }

  void isLoggedIn() {
    User user = _auth.currentUser;
    if (user != null) {
      isSignedIn = true;
    } else {
      isSignedIn = false;
    }
  }

  Future<CurrUser> getUserDetails() async {
    return CurrUser(uid: loggedInUser.uid, name: loggedInUser.phoneNumber);
  }
}
