import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/repo/auth_repo.dart';

part 'check_code_reset_password_state.dart';

class CheckCodeResetPasswordCubit extends Cubit<CheckCodeResetPasswordState> {
  CheckCodeResetPasswordCubit(this.authRepo)
    : super(CheckCodeResetPasswordInitial());
  final AuthRepo authRepo;
  Future<void> checkCodeResetPassword({
    required String email,
    required String code,
  }) async {
    emit(CheckCodeResetPasswordLoading());
    final result = await authRepo.checkCodeResetPassword(
      email: email,
      code: code,
    );
    result.fold(
      (failure) =>
          emit(CheckCodeResetPasswordFailure(errorMessage: failure.errMessage)),
      (data) => emit(CheckCodeResetPasswordSuccess()),
    );
  }
}
