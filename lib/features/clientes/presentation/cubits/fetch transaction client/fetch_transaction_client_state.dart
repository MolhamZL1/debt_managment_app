part of 'fetch_transaction_client_cubit.dart';

@immutable
sealed class FetchTransactionClientState {}

final class FetchTransactionClientInitial extends FetchTransactionClientState {}

final class FetchTransactionClientLoading extends FetchTransactionClientState {}

final class FetchTransactionClientError extends FetchTransactionClientState {
  final String errMessage;
  FetchTransactionClientError({required this.errMessage});
}

final class FetchTransactionClientSuccess extends FetchTransactionClientState {
  final List<dynamic> transactions;
  FetchTransactionClientSuccess({required this.transactions});
}
