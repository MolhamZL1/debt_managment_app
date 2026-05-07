part of 'fetch_debts_client_cubit.dart';

@immutable
sealed class FetchDebtsClientState {}

final class FetchDebtsClientInitial extends FetchDebtsClientState {}

final class FetchDebtsClientLoading extends FetchDebtsClientState {}

sealed class FetchDebtsClientDataState extends FetchDebtsClientState {
  final List<DebtEntity> debts;
  final bool hasMore;

  FetchDebtsClientDataState({required this.debts, required this.hasMore});
}

final class FetchDebtsClientSuccess extends FetchDebtsClientDataState {
  FetchDebtsClientSuccess({required super.debts, required super.hasMore});
}

final class FetchDebtsClientLoadingMore extends FetchDebtsClientDataState {
  FetchDebtsClientLoadingMore({required super.debts, required super.hasMore});
}

final class FetchDebtsClientLoadMoreError extends FetchDebtsClientDataState {
  final String failure;

  FetchDebtsClientLoadMoreError({
    required super.debts,
    required super.hasMore,
    required this.failure,
  });
}

final class FetchDebtsClientError extends FetchDebtsClientState {
  final String errMessage;
  FetchDebtsClientError({required this.errMessage});
}
