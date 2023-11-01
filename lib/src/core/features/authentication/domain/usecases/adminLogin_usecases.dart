import 'package:dartz/dartz.dart';

import '../../data/repositories/adminLogin_repo_impl.dart';
import '../entities/adminLogin_entity.dart';
import '../failures/failures.dart';

class AdminLoginUseCase {
  final adminLoginRepo = AdminLoginRepoImpl();

  Future<Either<Failure, AdminLoginEntity>> getCred(
      String email, String password) async {
    return adminLoginRepo.adminloginDataSource(
        email: email, password: password);
  }
}
