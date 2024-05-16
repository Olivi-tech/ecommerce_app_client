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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'doc_id': docId,
      'image_url': imageUrl,
      'product_code': productCode,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'delivery_charges': deliveryCharges,
      'discount': discount,
    };
  }

  factory EcommerceProductModel.fromMap(Map<String, dynamic> map) {
    return EcommerceProductModel(
      docId: map['doc_id'] != null ? map['doc_id'] as String : null,
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

  String toJson() => json.encode(toMap());

  factory EcommerceProductModel.fromJson(String source) =>
      EcommerceProductModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EcommerceProductModel(docId: $docId, imageUrl: $imageUrl, productCode: $productCode, title: $title, description: $description, category: $category, price: $price, deliveryCharges: $deliveryCharges, discount: $discount)';
  }

  @override
  bool operator ==(covariant EcommerceProductModel other) {
    if (identical(this, other)) return true;

    return other.docId == docId &&
        other.imageUrl == imageUrl &&
        other.productCode == productCode &&
        other.title == title &&
        other.description == description &&
        other.category == category &&
        other.price == price &&
        other.deliveryCharges == deliveryCharges &&
        other.discount == discount;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
        imageUrl.hashCode ^
        productCode.hashCode ^
        title.hashCode ^
        description.hashCode ^
        category.hashCode ^
        price.hashCode ^
        deliveryCharges.hashCode ^
        discount.hashCode;
  }
}
