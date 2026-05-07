part of 'fetch_all_transactions_cubit.dart';

@immutable
sealed class FetchAllTransactionsState {}

final class FetchAllTransactionsInitial extends FetchAllTransactionsState {}

sealed class FetchAllTransactionsDataState extends FetchAllTransactionsState {
  final List<TransactionEntity> transactions;
  final bool hasMore;

  FetchAllTransactionsDataState({
    required this.transactions,
    required this.hasMore,
  });
}

final class FetchAllTransactionsSuccess extends FetchAllTransactionsDataState {
  FetchAllTransactionsSuccess({
    required super.transactions,
    required super.hasMore,
  });
}

final class FetchAllTransactionsLoadingMore
    extends FetchAllTransactionsDataState {
  FetchAllTransactionsLoadingMore({
    required super.transactions,
    required super.hasMore,
  });
}

final class FetchAllTransactionsLoadMoreError
    extends FetchAllTransactionsDataState {
  final String errMessage;

  FetchAllTransactionsLoadMoreError({
    required super.transactions,
    required super.hasMore,
    required this.errMessage,
  });
}

final class FetchAllTransactionsLoading extends FetchAllTransactionsState {}

final class FetchAllTransactionsIFailure extends FetchAllTransactionsState {
  final String errMessage;

  FetchAllTransactionsIFailure({required this.errMessage});
}
