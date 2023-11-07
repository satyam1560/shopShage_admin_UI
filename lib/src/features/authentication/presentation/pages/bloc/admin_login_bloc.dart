import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'admin_login_event.dart';
part 'admin_login_state.dart';

class AdminLoginBloc extends Bloc<AdminLoginEvent, AdminLoginState> {
  AdminLoginBloc() : super(AdminLoginInitial()) {
    on<LoginButton>((event, emit) {
      emit(AdminLoginLoading());

      Future.delayed(const Duration(seconds: 5), () {
        // Simulate a successful login after a delay
        emit(AdminLoginSuccess());
        print('got success cred');
      });
    });
  }
  // AdminLoginBloc() : super(AdminLoginInitial()) {
  //   on<AdminLoginEvent>((event, emit) {});
  //   emit(AdminLoginSuccess());
  //   Future.delayed(const Duration(seconds: 5));
  //   print('got success cred');
  // }
}
