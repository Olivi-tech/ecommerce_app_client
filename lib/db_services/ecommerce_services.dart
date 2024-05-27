import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/deals_model.dart';
import 'package:shop_app/models/ecommerce_product_model.dart';
import 'package:shop_app/models/off_model.dart';

import '../models/cart_model.dart';

class EcommerceServices {
  static final fireStore = FirebaseFirestore.instance;
  static Stream<List<OffModel>> fetchOff() {
    return fireStore.collection('season_off').snapshots().map((query) {
      return query.docs
          .map((doc) => OffModel.fromJson(jsonData: doc.data()))
          .toList();
    });
  }
  static Stream<List<EcommerceProductModel>> fetchProducts() {
    return FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((e) {
        return EcommerceProductModel.fromMap(e.data());
      }).toList();
    });
  }
  static Stream<List<DealModel>> fetchDeal() {
    return FirebaseFirestore.instance
        .collection('deals')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((e) {
        return DealModel.fromMap(e.data());
      }).toList();
    });
  }
  static Future<void> uploadCartItem({
    required CartModel cartModel,
    required String docId,
  }) async {
    DocumentReference docRef = FirebaseFirestore.instance.collection('add_to_cart').doc(docId);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(docRef);
      if (snapshot.exists) {
        transaction.update(docRef, {
          'quantity': FieldValue.increment(cartModel.quantity ?? 1),
        });
      } else {
        transaction.set(docRef, cartModel.toMap());
      }
    }).catchError((error) {
      print("Failed to update cart item: $error");
    });
  }

  static Future<void> updateQuantity({required String docId, required bool increment}) async {
    DocumentReference docRef = FirebaseFirestore.instance.collection('add_to_cart').doc(docId);

    await docRef.update({
      'quantity': increment ? FieldValue.increment(1) : FieldValue.increment(-1),
    });
  }

  static Stream<List<CartModel>> fetchCartItem() {
    return FirebaseFirestore.instance
        .collection('add_to_cart')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((e) {
        return CartModel.fromMap(e.data());
      }).toList();
    });
  }
  static Future<void> deleteAllCartItems() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection('add_to_cart').get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
    in querySnapshot.docs) {
      await documentSnapshot.reference.delete();
    }
  }
}
