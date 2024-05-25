// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CartModel {
  int? quantity;
  String? docId;
  String? imageUrl;
  String? title;
  num? price;
  CartModel({
    this.docId,
    this.quantity,
    this.imageUrl,
    this.title,
    this.price,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quantity': quantity,
      'doc_id': docId,
      'image_url': imageUrl,
      'title': title,
      'price': price,
    };
  }
  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      quantity: map['quantity'] ?? '',
      docId: map['doc_id'] ?? '',
      imageUrl: map['image_url'] ?? '',
      title: map['title'] != null ? map['title'] as String : null,
      price: map['price'] != null ? map['price'] as num : null,

    );
  }
}
