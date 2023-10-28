part of 'order_tracking_bloc.dart';

abstract class OrderTrackingState extends Equatable {
  const OrderTrackingState();  

  @override
  List<Object> get props => [];
}
class OrderTrackingInitial extends OrderTrackingState {}
