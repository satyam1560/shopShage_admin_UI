import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/failures/failures.dart';
import '../../domain/usecases/adminLogin_usecases.dart';

part 'login_event.dart';
part 'login_state.dart';

const generalFailureMessage = 'Ups, something gone wrong. Please try again!';
const serverFailureMessage = 'Ups, API Error. please try again!';
const cacheFailureMessage = 'Ups, chache failed. Please try again!';

class LoginBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  LoginBloc() : super(AuthenticationInitialState()) {
    on<LoginButtonPressed>((event, emit) async {
      final AdminLoginUseCase adminLoginUseCase = AdminLoginUseCase();
      emit(AuthenticationLoadingState());

      debugPrint('fake get cred triggered');
      final crediential =
          await adminLoginUseCase.getCred(event.email, event.password);
      // await Future.delayed(const Duration(seconds: 3), () {});
      crediential.fold(
        (failure) => emit(
            AuthenticationFailedState(message: _mapFailureToMessage(failure))),
        ((sucess) => emit(AuthenticationSuccessfulState())),
      );
      debugPrint('got crediential');
    });
  }
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return generalFailureMessage;
    }
  }
}
