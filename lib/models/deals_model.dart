// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DealModel {
  String? docId;
  String? imageUrl;
  String? productCode;
  String? title;
  String? description;
  String? category;
  String? duration;
  bool? isFavourite;
  num? price;
  num? deliveryCharges;
  num? discount;
  DealModel({
    this.docId,
    this.imageUrl,
    this.productCode,
    this.title,
    this.isFavourite = false,
    this.description,
    this.category,
    this.duration,
    this.price,
    this.deliveryCharges,
    this.discount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': docId,
      'imageUrl': imageUrl,
      'productCode': productCode,
      'title': title,
      'description': description,
      'category': category,
      'duration': duration,
      'isFavourite': isFavourite,
      'price': price,
      'deliveryCharges': deliveryCharges,
      'discount': discount,
    };
  }

  factory DealModel.fromMap(Map<String, dynamic> map) {
    return DealModel(
      docId: map['doc_Id'] ?? '',
      imageUrl: map['image_url'] ?? '',
      productCode: map['product_code'] ?? '',
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      duration: map['duration'] != null ? map['duration'] as String : null,
      price: map['price'] != null ? map['price'] as num : null,
      deliveryCharges: map['delivery_charges'] != null
          ? map['delivery_charges'] as num
          : null,
      discount: map['discount'] != null ? map['discount'] as num : null,
    );
  }
}
