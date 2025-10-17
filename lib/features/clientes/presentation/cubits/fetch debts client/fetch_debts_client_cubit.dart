import 'package:bloc/bloc.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/debt_client_repo.dart';
import 'package:meta/meta.dart';

import '../../../../../core/entities/debt_entity.dart';

part 'fetch_debts_client_state.dart';

class FetchDebtsClientCubit extends Cubit<FetchDebtsClientState> {
  FetchDebtsClientCubit(this.debtClientRepo) : super(FetchDebtsClientInitial());
  final DebtClientRepo debtClientRepo;
  Future<void> fetchDebtsClient(int clientId) async {
    emit(FetchDebtsClientLoading());
    final result = await debtClientRepo.getAllDebtsOfClient(clientId);
    result.fold(
      (failure) => emit(FetchDebtsClientError(errMessage: failure.errMessage)),
      (debts) => emit(FetchDebtsClientSuccess(debts: debts)),
    );
  }
}
