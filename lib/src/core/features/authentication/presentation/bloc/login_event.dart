part of 'login_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginButtonPressed extends AuthenticationEvent {
  final String email;
  final String password;
  LoginButtonPressed({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}
