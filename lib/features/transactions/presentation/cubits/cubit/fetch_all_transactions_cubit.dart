import 'package:bloc/bloc.dart';
import 'package:debt_managment_app/features/transactions/domain/entities/transaction_entity.dart';
import 'package:debt_managment_app/features/transactions/domain/repo/transaction_repo.dart';
import 'package:meta/meta.dart';

part 'fetch_all_transactions_state.dart';

class FetchAllTransactionsCubit extends Cubit<FetchAllTransactionsState> {
  FetchAllTransactionsCubit(this.transactionRepo)
    : super(FetchAllTransactionsInitial());
  final TransactionRepo transactionRepo;
  static const int _pageSize = 10;

  int _currentPage = 1;
  bool _isFetchingMore = false;
  String currentCategory = "all";

  Future<void> getAllTransactions({required String category}) async {
    currentCategory = category;
    _currentPage = 1;
    emit(FetchAllTransactionsLoading());

    final result = await transactionRepo.getAllTransactions(
      category: category,
      page: _currentPage,
    );

    result.fold(
      (l) => emit(FetchAllTransactionsIFailure(errMessage: l.errMessage)),
      (r) => emit(
        FetchAllTransactionsSuccess(
          transactions: r,
          hasMore: r.length == _pageSize,
        ),
      ),
    );
  }

  Future<void> fetchMoreTransactions() async {
    final currentState = state;
    if (currentState is! FetchAllTransactionsDataState) {
      return;
    }
    if (_isFetchingMore || !currentState.hasMore) {
      return;
    }

    _isFetchingMore = true;

    emit(
      FetchAllTransactionsLoadingMore(
        transactions: currentState.transactions,
        hasMore: currentState.hasMore,
      ),
    );

    final nextPage = _currentPage + 1;
    final result = await transactionRepo.getAllTransactions(
      category: currentCategory,
      page: nextPage,
    );

    result.fold(
      (l) => emit(
        FetchAllTransactionsLoadMoreError(
          transactions: currentState.transactions,
          hasMore: currentState.hasMore,
          errMessage: l.errMessage,
        ),
      ),
      (r) {
        _currentPage = nextPage;
        emit(
          FetchAllTransactionsSuccess(
            transactions: [...currentState.transactions, ...r],
            hasMore: r.length == _pageSize,
          ),
        );
      },
    );

    _isFetchingMore = false;
  }
}
