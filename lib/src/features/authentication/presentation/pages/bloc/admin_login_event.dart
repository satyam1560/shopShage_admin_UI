part of 'admin_login_bloc.dart';

sealed class AdminLoginEvent extends Equatable {
  const AdminLoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginButton extends AdminLoginEvent {
  final String email;
  final String password;
  const LoginButton({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
