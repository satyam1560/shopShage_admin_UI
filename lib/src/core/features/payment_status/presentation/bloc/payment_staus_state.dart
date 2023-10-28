part of 'payment_staus_bloc.dart';

abstract class PaymentStausState extends Equatable {
  const PaymentStausState();  

  @override
  List<Object> get props => [];
}
class PaymentStausInitial extends PaymentStausState {}
