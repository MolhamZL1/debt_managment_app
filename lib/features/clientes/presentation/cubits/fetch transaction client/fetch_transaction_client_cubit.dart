import 'package:bloc/bloc.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/transaction_client_repo.dart';
import 'package:meta/meta.dart';

part 'fetch_transaction_client_state.dart';

class FetchTransactionClientCubit extends Cubit<FetchTransactionClientState> {
  FetchTransactionClientCubit(this.transactionClientRepo)
    : super(FetchTransactionClientInitial());
  final TransactionClientRepo transactionClientRepo;

  Future<void> fetchTransactionClient(int clientId) async {
    emit(FetchTransactionClientLoading());
    final result = await transactionClientRepo.getAllTransactionsOfClient(
      clientId,
    );
    result.fold(
      (l) => emit(FetchTransactionClientError(errMessage: l.errMessage)),
      (r) => emit(FetchTransactionClientSuccess(transactions: r)),
    );
  }
}
