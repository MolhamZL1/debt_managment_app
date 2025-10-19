part of 'fetch_all_transactions_cubit.dart';

@immutable
sealed class FetchAllTransactionsState {}

final class FetchAllTransactionsInitial extends FetchAllTransactionsState {}

final class FetchAllTransactionsSuccess extends FetchAllTransactionsState {
  final List<TransactionEntity> transactions;

  FetchAllTransactionsSuccess({required this.transactions});
}

final class FetchAllTransactionsLoading extends FetchAllTransactionsState {}

final class FetchAllTransactionsIFailure extends FetchAllTransactionsState {
  final String errMessage;

  FetchAllTransactionsIFailure({required this.errMessage});
}
