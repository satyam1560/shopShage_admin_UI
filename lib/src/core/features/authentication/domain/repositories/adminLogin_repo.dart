import 'package:dartz/dartz.dart';

import '../entities/adminLogin_entity.dart';
import '../failures/failures.dart';

abstract class AdminLoginRepo {
  Future<Either<Failure, AdminLoginEntity>> getAdminLoginFromDatasource(
      String email, String password);
}
