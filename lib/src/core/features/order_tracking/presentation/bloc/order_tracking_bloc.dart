import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'order_tracking_event.dart';
part 'order_tracking_state.dart';

class OrderTrackingBloc extends Bloc<OrderTrackingEvent, OrderTrackingState> {
  OrderTrackingBloc() : super(OrderTrackingInitial()) {
    on<OrderTrackingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
