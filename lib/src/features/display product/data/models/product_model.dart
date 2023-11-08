// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class ProductObject {
  String id;
  String title;
  String description;
  num productPrice;
  String productImgUrl;
  int productQuantity;
  ProductObject({
    required this.id,
    required this.title,
    required this.description,
    required this.productPrice,
    required this.productImgUrl,
    required this.productQuantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'productPrice': productPrice,
      'productImgUrl': productImgUrl,
      'productQuantity': productQuantity,
    };
  }

  factory ProductObject.fromMap(Map<String, dynamic> map) {
    return ProductObject(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      productPrice: map['productPrice'] ?? '',
      productImgUrl: map['productImgUrl'] ?? '',
      productQuantity: map['productQuantity'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());

  factory ProductObject.fromJson(String source) =>
      ProductObject.fromMap(json.decode(source) as Map<String, dynamic>);
}
