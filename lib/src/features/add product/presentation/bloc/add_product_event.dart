// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_product_bloc.dart';

abstract class AddProductEvent extends Equatable {
  const AddProductEvent();

  @override
  List<Object?> get props => [];
}

class AddProduct extends AddProductEvent {
  final String title;
  final String description;
  final num productPrice;
  final String productImgUrl;
  final int productQuantity;
  const AddProduct({
    required this.title,
    required this.description,
    required this.productPrice,
    required this.productImgUrl,
    required this.productQuantity,
  });
  @override
  List<Object?> get props =>
      [title, description, productPrice, productImgUrl, productQuantity];
}
