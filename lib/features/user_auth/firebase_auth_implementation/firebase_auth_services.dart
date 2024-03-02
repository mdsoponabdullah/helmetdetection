import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../../../global/common/toast.dart';

class FirebaseAuthServices {

  static bool emailVerified = false;



  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {

      if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
        CommonMessage.showToast(message: 'Invalid email or password.');
      } else {


        CommonMessage.showToast(message: 'An error occurred: ${e.code}');

      }
    }

    return null;
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      sendEmailVerification();

      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        CommonMessage.showToast(message: 'The email address is already in use.');
      } else {
        CommonMessage.showToast(message: 'An error occurred : ${e.code}');
      }
    }
    return null;
  }



  Future<void> sendEmailVerification() async {

    User? user = _auth.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      // Handle the case where the user is not signed in
      print("User is not signed in.");
    }
  }



     Future<void> checkEmailVerification(String userId) async {
       FirebaseFirestore db = FirebaseFirestore.instance;
    await FirebaseAuth.instance.currentUser!.reload();
    User? user = _auth.currentUser;
       emailVerified= FirebaseAuth.instance.currentUser!.emailVerified;
   if(user != null && emailVerified)
     {


       db.collection("users").doc(userId).set({
         "verified": true,
       }, SetOptions(merge: emailVerified));
     }


  }

}
