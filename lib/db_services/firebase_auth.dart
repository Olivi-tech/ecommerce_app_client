// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/app_utils.dart';

class AuthServices {
  static User? get currentUser {
    return FirebaseAuth.instance.currentUser;
  }
  static Future<void> signIn(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
  static Future<bool> signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        return true;
      } else {
        log('Sign-Up Failed');
        return false;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        AppUtils.toastMessage('The account already exists for that email.');
        return false;
      } else if (e.code == 'weak-password') {
        AppUtils.toastMessage('The password provided is too weak.');
        return false;
      }
      AppUtils.toastMessage('Error: ${e.message}');
      return false;
    }
  }

  static Future<bool> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        return true;
      } else {
        log('Not Login');
        return false;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AppUtils.toastMessage('No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        AppUtils.toastMessage('Wrong password provided for that user.');
        return false;
      }
      return false;
    }
  }

  static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<String> forgotPassword(
      {required String email, required BuildContext context}) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    // try {
    await firebaseAuth.sendPasswordResetEmail(email: email);
    return '..';
    // } on FirebaseAuthException catch (err) {
    // return "${err.message}";
  }
}
// }
