import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/repo/auth_repo.dart';

part 'verfy_email_state.dart';

class VerfyEmailCubit extends Cubit<VerfyEmailState> {
  VerfyEmailCubit(this.authRepo) : super(VerfyEmailInitial());
  final AuthRepo authRepo;
  void verfyEmail({required String email, required String code}) async {
    emit(VerfyEmailLoading());
    final result = await authRepo.verfyEmail(code: code, email: email);
    result.fold(
      (l) => emit(VerfyEmailFailure(message: l.errMessage)),
      (r) => emit(VerfyEmailSucces()),
    );
  }
}
