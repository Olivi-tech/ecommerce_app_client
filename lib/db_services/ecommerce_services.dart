import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/models/deals_model.dart';
import 'package:shop_app/models/ecommerce_product_model.dart';
import 'package:shop_app/models/off_model.dart';

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
}
