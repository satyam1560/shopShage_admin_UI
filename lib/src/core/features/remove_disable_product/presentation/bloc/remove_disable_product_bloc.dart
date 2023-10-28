import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'remove_disable_product_event.dart';
part 'remove_disable_product_state.dart';

class RemoveDisableProductBloc extends Bloc<RemoveDisableProductEvent, RemoveDisableProductState> {
  RemoveDisableProductBloc() : super(RemoveDisableProductInitial()) {
    on<RemoveDisableProductEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
