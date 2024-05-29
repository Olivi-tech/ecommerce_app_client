import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class EcommerceProductModel {
  String? docId;
  String? imageUrl;
  String? productCode;
  String? title;
  String? description;
  String? category;
  num? price;
  num? deliveryCharges;
  num? discount;
  EcommerceProductModel({
    this.docId,
    this.imageUrl,
    this.productCode,
    this.title,
    this.description,
    this.category,
    this.price,
    this.deliveryCharges,
    this.discount,
  });



  factory EcommerceProductModel.fromMap(Map<String, dynamic> map) {
    if (map['docId'] == null) {
      print('doc_id is null');
    } else {
      print('doc_id is not null');
    }
    return EcommerceProductModel(
      docId: map['docId'] != null ? map['docId'] as String : null,

      imageUrl: map['image_url'] != null ? map['image_url'] as String : null,
      productCode:
          map['product_code'] != null ? map['product_code'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      price: map['price'] != null ? map['price'] as num : null,
      deliveryCharges: map['delivery_charges'] != null
          ? map['delivery_charges'] as num
          : null,
      discount: map['discount'] != null ? map['discount'] as num : null,
    );
  }

}
