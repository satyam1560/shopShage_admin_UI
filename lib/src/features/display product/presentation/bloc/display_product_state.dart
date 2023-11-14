// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'display_product_bloc.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState extends Equatable {
  final ProductStatus productStatus;
  final List<Product>? products;
  final Product? product;
  final String failure;
  const ProductState({
    required this.productStatus,
    required this.products,
    this.product,
    required this.failure,
  });

  ProductState copyWith({
    ProductStatus? productStatus,
    List<Product>? products,
    Product? product,
    String? failure,
  }) {
    return ProductState(
      productStatus: productStatus ?? this.productStatus,
      products: products ?? this.products,
      product: product ?? this.product,
      failure: failure ?? this.failure,
    );
  }

  factory ProductState.inital() => const ProductState(
        productStatus: ProductStatus.initial,
        products: [],
        failure: '',
      );

  @override
  bool get stringify => true;
  @override
  List<Object?> get props => [productStatus, products, product, failure];
}
