part of 'admin_login_bloc.dart';

sealed class AdminLoginState extends Equatable {
  const AdminLoginState();

  @override
  List<Object?> get props => [];
}

final class AdminLoginInitial extends AdminLoginState {}

final class AdminLoginLoading extends AdminLoginState {}

final class AdminLoginSuccess extends AdminLoginState {}

final class AdminLoginFailure extends AdminLoginState {
  final String message;
  const AdminLoginFailure({required this.message});
  @override
  List<Object?> get props => [message];
}
