import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import '../exceptions/exceptions.dart';
import '../models/admin_model.dart';

abstract class AdminloginDataSource {
  Future<AdminModel> getAdminLoginFromFirebase(email, password);
}

class AdminloginDataSourceImpl implements AdminloginDataSource {
  @override
  Future<AdminModel> getAdminLoginFromFirebase(email, password) async {
    final auth = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    if (auth.user != 200) {
      throw ServerException();
    } else {
      final responseBody = json.decode(auth.body);
      return AdminModel.fromJson(responseBody);
    }
  }
}
