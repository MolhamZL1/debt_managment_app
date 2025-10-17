part of 'fetch_debts_client_cubit.dart';

@immutable
sealed class FetchDebtsClientState {}

final class FetchDebtsClientInitial extends FetchDebtsClientState {}

final class FetchDebtsClientLoading extends FetchDebtsClientState {}

final class FetchDebtsClientSuccess extends FetchDebtsClientState {
  final List<DebtEntity> debts;
  FetchDebtsClientSuccess({required this.debts});
}

final class FetchDebtsClientError extends FetchDebtsClientState {
  final String errMessage;
  FetchDebtsClientError({required this.errMessage});
}
