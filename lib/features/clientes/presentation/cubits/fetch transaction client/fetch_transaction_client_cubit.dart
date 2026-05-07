import 'package:bloc/bloc.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/transaction_client_repo.dart';
import 'package:meta/meta.dart';

part 'fetch_transaction_client_state.dart';

class FetchTransactionClientCubit extends Cubit<FetchTransactionClientState> {
  FetchTransactionClientCubit(this.transactionClientRepo)
    : super(FetchTransactionClientInitial());
  final TransactionClientRepo transactionClientRepo;
  static const int _pageSize = 10;

  int _currentPage = 1;
  int? _currentClientId;
  bool _isFetchingMore = false;

  Future<void> fetchTransactionClient(int clientId) async {
    _currentClientId = clientId;
    _currentPage = 1;
    emit(FetchTransactionClientLoading());

    final result = await transactionClientRepo.getAllTransactionsOfClient(
      clientId,
      page: _currentPage,
    );

    result.fold(
      (l) => emit(FetchTransactionClientError(errMessage: l.errMessage)),
      (r) => emit(
        FetchTransactionClientSuccess(
          transactions: r,
          hasMore: r.length == _pageSize,
        ),
      ),
    );
  }

  Future<void> fetchMoreTransactionClient() async {
    final currentState = state;
    if (currentState is! FetchTransactionClientDataState) {
      return;
    }
    if (_isFetchingMore || !currentState.hasMore || _currentClientId == null) {
      return;
    }

    _isFetchingMore = true;

    emit(
      FetchTransactionClientLoadingMore(
        transactions: currentState.transactions,
        hasMore: currentState.hasMore,
      ),
    );

    final nextPage = _currentPage + 1;
    final result = await transactionClientRepo.getAllTransactionsOfClient(
      _currentClientId!,
      page: nextPage,
    );

    result.fold(
      (failure) => emit(
        FetchTransactionClientLoadMoreError(
          transactions: currentState.transactions,
          hasMore: currentState.hasMore,
          failure: failure.errMessage,
        ),
      ),
      (transactions) {
        _currentPage = nextPage;
        emit(
          FetchTransactionClientSuccess(
            transactions: [...currentState.transactions, ...transactions],
            hasMore: transactions.length == _pageSize,
          ),
        );
      },
    );

    _isFetchingMore = false;
  }
}
