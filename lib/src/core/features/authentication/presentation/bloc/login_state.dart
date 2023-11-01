part of 'login_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object?> get props => [];
}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationSuccessfulState extends AuthenticationState {
  // final String advice;
  // AdvicerStateLoaded({required this.advice});

  // @override
  // List<Object?> get props => [advice];
}

class AuthenticationFailedState extends AuthenticationState {
  final String message;
  const AuthenticationFailedState({required this.message});
  @override
  List<Object?> get props => [message];
}
