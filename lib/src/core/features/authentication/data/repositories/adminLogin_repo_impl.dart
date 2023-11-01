import 'package:dartz/dartz.dart';

import '../../domain/entities/adminLogin_entity.dart';
import '../../domain/failures/failures.dart';
import '../../domain/repositories/adminLogin_repo.dart';
import '../datasources/adminlogin_dataSource.dart';
import '../exceptions/exceptions.dart';

class AdminLoginRepoImpl implements AdminLoginRepo {
  final AdminloginDataSource adminloginDataSource = AdminloginDataSourceImpl();
  @override
  Future<Either<Failure, AdminLoginEntity>> getAdminLoginFromDatasource(
      String email, String password) async {
    try {
      final result =
          await adminloginDataSource.getAdminLoginFromFirebase(email, password);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
