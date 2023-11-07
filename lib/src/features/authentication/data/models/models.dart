class CustomUser {
  final String email;
  final bool isAuth;
  final String uid;

  CustomUser({
    required this.email,
    required this.uid,
    required this.isAuth,
  });

  factory CustomUser.fromJson(Map<String, dynamic> map, bool autherization) {
    return CustomUser(
      uid: map['id'] ?? '',
      email: map['email'] ?? '',
      isAuth: autherization,
    );
  }
}
