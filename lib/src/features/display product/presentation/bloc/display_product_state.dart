part of 'display_product_bloc.dart';

abstract class DisplayProductState extends Equatable {
  const DisplayProductState();

  @override
  List<Object?> get props => [];
}
// class DisplayProductInitial extends DisplayProductState {}

final class DisplayProductDataInitial extends DisplayProductState {}

final class DisplayProductDataLoading extends DisplayProductState {}

final class DisplayProductDataLoaded extends DisplayProductState {
  final List<ProductObject> products;
  const DisplayProductDataLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

final class DisplayProductDataError extends DisplayProductState {
  final String error;
  const DisplayProductDataError(this.error);
  @override
  List<Object?> get props => [error];
}
