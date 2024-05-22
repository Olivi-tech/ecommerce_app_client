import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/prfile_model.dart';

class FireStoreServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<void> addUser(String address, String firstName, String lastName,
      String phoneNumber) async {
    DocumentReference users = FirebaseFirestore.instance
        .collection('users_data')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    var model = ProfileModel(
        address: address,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber);
    users.set(model.toJson());
  }
}
