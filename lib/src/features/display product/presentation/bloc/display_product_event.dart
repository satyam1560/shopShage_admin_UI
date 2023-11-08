part of 'display_product_bloc.dart';

abstract class DisplayProductEvent extends Equatable {
  const DisplayProductEvent();

  @override
  List<Object?> get props => [];
}

class DisplayProductItems extends DisplayProductEvent {}
