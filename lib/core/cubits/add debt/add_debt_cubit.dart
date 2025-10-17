import 'package:bloc/bloc.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/debt_client_repo.dart';
import 'package:meta/meta.dart';

part 'add_debt_state.dart';

class AddDebtCubit extends Cubit<AddDebtState> {
  AddDebtCubit(this.debtClientRepo) : super(AddDebtInitial());
  final DebtClientRepo debtClientRepo;

  Future<void> addDebt(int clientId, String? description, double amount) async {
    emit(AddDebtLoading());
    final result = await debtClientRepo.addDebtToClient(
      clientId,
      amount,
      description,
    );
    result.fold(
      (failure) => emit(AddDebtError(errMessage: failure.errMessage)),
      (success) => emit(AddDebtSuccess()),
    );
  }
}
