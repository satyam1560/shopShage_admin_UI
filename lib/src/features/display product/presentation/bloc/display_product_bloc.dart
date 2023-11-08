import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/datasources/display_product_datasource.dart';
import '../../data/models/product_model.dart';

part 'display_product_event.dart';
part 'display_product_state.dart';

class DisplayProductBloc
    extends Bloc<DisplayProductEvent, DisplayProductState> {
  final DisplayProductRepository displayProductRepository;
  DisplayProductBloc(this.displayProductRepository)
      : super(DisplayProductDataInitial()) {
    on<DisplayProductItems>((event, emit) async {
      emit(DisplayProductDataLoading());
      try {
        final products = await displayProductRepository.getProducts();
        emit(DisplayProductDataLoaded(products));
      } catch (e) {
        emit(DisplayProductDataError(e.toString()));
      }
    });
  }
}
