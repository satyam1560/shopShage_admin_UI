import 'package:equatable/equatable.dart';

class AdminLoginEntity extends Equatable {
  final String email;
  final String password;
  final int? id;

  const AdminLoginEntity(
      {required this.email, required this.password, this.id});

  @override
  List<Object?> get props => [email, password, id];
}
