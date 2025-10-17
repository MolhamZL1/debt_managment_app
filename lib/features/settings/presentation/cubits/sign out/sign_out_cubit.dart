import 'package:bloc/bloc.dart';
import 'package:debt_managment_app/features/auth/domain/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  SignOutCubit(this.authRepo) : super(SignOutInitial());
  final AuthRepo authRepo;

  Future<void> signOut() async {
    emit(SignOutLoading());
    final result = await authRepo.signOut();
    result.fold(
      (l) => emit(SignOutError(errMessage: l.errMessage)),
      (r) => emit(SignOutSuccess()),
    );
  }
}
