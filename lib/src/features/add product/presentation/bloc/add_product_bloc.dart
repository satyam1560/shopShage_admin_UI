import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/datasources/add_product_datasource.dart';
import '../../data/models/product_model.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final ProductRepository productRepository;

  AddProductBloc({required this.productRepository})
      : super(AddProductInitialState()) {
    on<AddProduct>((event, emit) async {
      emit(AddProductLoadingState());

      // Create a ProductModel from the event's data
      final ProductModel productDetails = ProductModel(
        title: event.title,
        description: event.description,
        productPrice: event.productPrice,
        productImgUrl: event.productImgUrl,
        productQuantity: event.productQuantity,
      );

      try {
        // Add the product using the repository
        await productRepository.addProduct(productDetails);

        emit(AddProductLoadedState());
      } catch (e) {
        emit(AddProductErrorState(error: e.toString()));
      }
    });
  }
}
