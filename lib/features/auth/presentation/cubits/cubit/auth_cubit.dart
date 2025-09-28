import 'package:bloc/bloc.dart';
import 'package:debt_managment_app/features/auth/domain/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  final AuthRepo authRepo;

  void signIn(String email, String password) async {
    emit(AuthLoading());
    final result = await authRepo.signIn(email, password);
    result.fold(
      (l) => emit(AuthFailure(l.errMessage)),
      (r) => emit(AuthSuccess()),
    );
  }

  void signUp(
    String name,
    String phoneNumber,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    emit(AuthLoading());
    final result = await authRepo.signUp(
      name,
      phoneNumber,
      email,
      password,
      passwordConfirmation,
    );
    result.fold(
      (l) => emit(AuthFailure(l.errMessage)),
      (r) => emit(AuthSuccess()),
    );
  }
}
