import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/datasources/display_product_datasource.dart';
import '../../data/models/product_model.dart';

part 'display_product_event.dart';
part 'display_product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository = ProductRepository();

  ProductBloc() : super(ProductState.inital()) {
    on<DisplayProductItems>((event, emit) async {
      try {
        emit(state.copyWith(productStatus: ProductStatus.loading));

        final products = await _productRepository.getProducts();

        emit(state.copyWith(
          products: products,
          productStatus: ProductStatus.success,
        ));
      } catch (e) {
        emit(state.copyWith(
          productStatus: ProductStatus.failure,
          failure: e.toString(),
        ));
      }
    });

    on<AddProduct>((event, emit) async {
      try {
        emit(state.copyWith(productStatus: ProductStatus.loading));
        final product =
            await _productRepository.addProduct(product: event.product);
        print('********$product');
        if (product != null) {
          emit(state.copyWith(
              product: product, productStatus: ProductStatus.success));
        } else {
          emit(state.copyWith(
            productStatus: ProductStatus.failure,
            failure: "Failed to add the product",
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          productStatus: ProductStatus.failure,
          failure: e.toString(),
        ));
      }
    });

    on<EditProduct>((event, emit) async {
      try {
        emit(state.copyWith(productStatus: ProductStatus.loading));
        final product =
            await _productRepository.updateProduct(product: event.product);
        emit(state.copyWith(
            productStatus: ProductStatus.success, product: product));
      } catch (e) {
        emit(state.copyWith(
          productStatus: ProductStatus.failure,
          failure: e.toString(),
        ));
      }
    });

    on<DeleteProduct>((event, emit) {
      try {
        emit(state.copyWith(productStatus: ProductStatus.loading));
        _productRepository.deleteProduct(productToDelete: event.id);
        emit(state.copyWith(productStatus: ProductStatus.success));
      } catch (e) {
        emit(state.copyWith(
            productStatus: ProductStatus.failure, failure: e.toString()));
      }
    });
  }
}
