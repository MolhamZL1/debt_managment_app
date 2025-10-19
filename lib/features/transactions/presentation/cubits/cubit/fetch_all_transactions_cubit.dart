import 'package:bloc/bloc.dart';
import 'package:debt_managment_app/features/transactions/domain/entities/transaction_entity.dart';
import 'package:debt_managment_app/features/transactions/domain/repo/transaction_repo.dart';
import 'package:meta/meta.dart';

part 'fetch_all_transactions_state.dart';

class FetchAllTransactionsCubit extends Cubit<FetchAllTransactionsState> {
  FetchAllTransactionsCubit(this.transactionRepo)
    : super(FetchAllTransactionsInitial());
  final TransactionRepo transactionRepo;
  Future<void> getAllTransactions({required String category}) async {
    emit(FetchAllTransactionsLoading());
    final result = await transactionRepo.getAllTransactions(category: category);
    result.fold(
      (l) => emit(FetchAllTransactionsIFailure(errMessage: l.errMessage)),
      (r) => emit(FetchAllTransactionsSuccess(transactions: r)),
    );
  }
}
