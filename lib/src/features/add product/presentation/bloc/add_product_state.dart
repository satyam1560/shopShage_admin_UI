part of 'add_product_bloc.dart';

abstract class AddProductState extends Equatable {
  const AddProductState();

  @override
  List<Object?> get props => [];
}

class AddProductInitialState extends AddProductState {}

class AddProductLoadingState extends AddProductState {}

class AddProductLoadedState extends AddProductState {}

class AddProductErrorState extends AddProductState {
  final String error;
  const AddProductErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}
