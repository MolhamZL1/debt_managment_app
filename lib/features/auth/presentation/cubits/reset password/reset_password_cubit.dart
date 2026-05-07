import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/repo/auth_repo.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this.authRepo) : super(ResetPasswordInitial());
  final AuthRepo authRepo;
  resetPassword({
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(ResetPasswordLoading());
    final result = await authRepo.resetPassword(
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    result.fold(
      (failure) => emit(ResetPasswordFailure(errorMessage: failure.errMessage)),
      (data) => emit(ResetPasswordSuccess()),
    );
  }
}
