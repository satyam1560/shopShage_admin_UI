import '../../domain/entities/adminLogin_entity.dart';

class AdminModel extends AdminLoginEntity {
  const AdminModel(
      {required String email, required String password, required int id})
      : super(email: email, password: password, id: id);

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'],
      email: json['email'],
      password: json['password'],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, email, password];
}
