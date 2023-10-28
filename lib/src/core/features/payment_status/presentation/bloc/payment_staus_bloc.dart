import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_staus_event.dart';
part 'payment_staus_state.dart';

class PaymentStausBloc extends Bloc<PaymentStausEvent, PaymentStausState> {
  PaymentStausBloc() : super(PaymentStausInitial()) {
    on<PaymentStausEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
