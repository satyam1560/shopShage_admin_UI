// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CustomUser {
  String? email;
  String? password;
  bool? isAuth;
  String? uid;

  CustomUser({
    this.password,
    this.email,
    this.uid,
    this.isAuth,
  });

  // factory CustomUser.fromJson(Map<String, dynamic> map, bool autherization) {
  //   return CustomUser(
  //     uid: map['id'] ?? '',
  //     email: map['email'] ?? '',
  //     isAuth: autherization, password: '',
  //   );
  // }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'isAuth': isAuth,
      'uid': uid,
    };
  }

  factory CustomUser.fromMap(Map<String, dynamic> map) {
    return CustomUser(
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      isAuth: map['isAuth'] != null ? map['isAuth'] as bool : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomUser.fromJson(String source, bool isAuthorized) =>
      CustomUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
