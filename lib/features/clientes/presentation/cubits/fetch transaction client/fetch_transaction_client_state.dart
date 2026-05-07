part of 'fetch_transaction_client_cubit.dart';

@immutable
sealed class FetchTransactionClientState {}

final class FetchTransactionClientInitial extends FetchTransactionClientState {}

final class FetchTransactionClientLoading extends FetchTransactionClientState {}

final class FetchTransactionClientError extends FetchTransactionClientState {
  final String errMessage;
  FetchTransactionClientError({required this.errMessage});
}

sealed class FetchTransactionClientDataState
    extends FetchTransactionClientState {
  final List<dynamic> transactions;
  final bool hasMore;

  FetchTransactionClientDataState({
    required this.transactions,
    required this.hasMore,
  });
}

final class FetchTransactionClientSuccess
    extends FetchTransactionClientDataState {
  FetchTransactionClientSuccess({
    required super.transactions,
    required super.hasMore,
  });
}

final class FetchTransactionClientLoadingMore
    extends FetchTransactionClientDataState {
  FetchTransactionClientLoadingMore({
    required super.transactions,
    required super.hasMore,
  });
}

final class FetchTransactionClientLoadMoreError
    extends FetchTransactionClientDataState {
  final String failure;

  FetchTransactionClientLoadMoreError({
    required super.transactions,
    required super.hasMore,
    required this.failure,
  });
}
