import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/repo/auth_repo.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.authRepo) : super(SignUpInitial());
  final AuthRepo authRepo;
  void signUp(
    String name,
    String phoneNumber,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    emit(SignUpLoading());
    final result = await authRepo.signUp(
      name,
      phoneNumber,
      email,
      password,
      passwordConfirmation,
    );
    result.fold(
      (l) => emit(SignUpFailure(l.errMessage)),
      (r) => emit(SignUpSuccess()),
    );
  }
}
