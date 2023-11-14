import 'package:bloc/bloc.dart';
import 'package:ecommerce/src/features/authentication/data/data%20source/admin_auth_datasource.dart';
import 'package:ecommerce/src/features/authentication/data/models/models.dart';
import 'package:equatable/equatable.dart';

part 'admin_login_event.dart';
part 'admin_login_state.dart';

class AdminLoginBloc extends Bloc<AdminLoginEvent, AdminLoginState> {
  GetAdminAuth getAdminAuth = GetAdminAuth();
  AdminLoginBloc() : super(AdminLoginInitial()) {
    on<LoginButton>((event, emit) async {
      emit(AdminLoginLoading());
      CustomUser customUser =
          CustomUser(email: event.email, password: event.password);

      bool isAuth = await getAdminAuth.getAdminAuth(customUser);
      print('isAuth at bloc------$isAuth');
      if (isAuth) {
        emit(AdminLoginSuccess());
      } else {
        emit(const AdminLoginFailure(message: 'Authentication failed.'));
      }
    });
  }
}
