import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/repo/auth_repo.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.authRepo) : super(ForgetPasswordInitial());
  final AuthRepo authRepo;
  forgetpassword(String email) async {
    emit(ForgetPasswordLoading());
    final result = await authRepo.forgetPassword(email: email);
    result.fold(
      (failure) {
        emit(ForgetPasswordFailure(failure.errMessage));
      },
      (message) {
        emit(ForgetPasswordSuccess());
      },
    );
  }
}
