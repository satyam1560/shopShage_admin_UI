// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  String? id;
  String? title;
  String? description;
  num? productPrice;
  String? productImgUrl;
  int? productQuantity;
  num? sellingPrice;
  Product({
    this.id,
    this.title,
    this.description,
    this.productPrice,
    this.productImgUrl,
    this.productQuantity,
    this.sellingPrice,
  });

  Product copyWith({
    String? id,
    String? title,
    String? description,
    num? productPrice,
    String? productImgUrl,
    int? productQuantity,
    num? sellingPrice,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      productPrice: productPrice ?? this.productPrice,
      productImgUrl: productImgUrl ?? this.productImgUrl,
      productQuantity: productQuantity ?? this.productQuantity,
      sellingPrice: sellingPrice ?? this.sellingPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'productPrice': productPrice,
      'productImgUrl': productImgUrl,
      'productQuantity': productQuantity,
      'sellingPrice': sellingPrice,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      productPrice: map['productPrice'] ?? '',
      productImgUrl: map['productImgUrl'] ?? '',
      productQuantity: map['productQuantity'] ?? '0',
      sellingPrice: map['sellingPrice'] ?? 0,
    );
  }
  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
  @override
  List<Object?> get props => [
        id,
        title,
        description,
        productPrice,
        productImgUrl,
        productQuantity,
        sellingPrice
      ];
}
