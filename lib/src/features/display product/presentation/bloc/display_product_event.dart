part of 'display_product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class DisplayProductItems extends ProductEvent {}

class AddProduct extends ProductEvent {
  final Product product;
  const AddProduct({required this.product});
  @override
  List<Object?> get props => [product];
}

class EditProduct extends ProductEvent {
  final Product product;
  const EditProduct({required this.product});
  @override
  List<Object?> get props => [product];
}

class DeleteProduct extends ProductEvent {
  final Product id;
  const DeleteProduct({required this.id});
  @override
  List<Object?> get props => [id];
}
