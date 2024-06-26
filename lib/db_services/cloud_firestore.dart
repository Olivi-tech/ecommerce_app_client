import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shop_app/models/prfile_model.dart';
import 'firebase_auth.dart';
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

  //Upload image on firebase
  static Future<String?> uploadOrUpdateImage({
    required String imagePath,
  }) async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref('profile_image')
          .child(AuthServices.currentUser!.uid);
      await ref.putFile(
          File(imagePath), SettableMetadata(contentType: 'image/png'));
      return await ref.getDownloadURL();
    } on FirebaseException catch (error) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        log('Error: ${error.toString()}');
      });
    }
    return null;
  }
  //update image on firebase just in firebase storage
  static Future<void> updateCurrentUserProfile(String imageUrl) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updatePhotoURL(imageUrl);
      await user.reload();
    }
  }
}

