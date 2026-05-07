part of 'fetch_payments_clients_cubit.dart';

@immutable
sealed class FetchPaymentsClientsState {}

final class FetchPaymentsClientsInitial extends FetchPaymentsClientsState {}

final class FetchPaymentsClientsLoading extends FetchPaymentsClientsState {}

final class FetchPaymentsClientsError extends FetchPaymentsClientsState {
  final String errMessage;
  FetchPaymentsClientsError({required this.errMessage});
}

sealed class FetchPaymentsClientsDataState extends FetchPaymentsClientsState {
  final List<PaymentEntity> payments;
  final bool hasMore;

  FetchPaymentsClientsDataState({
    required this.payments,
    required this.hasMore,
  });
}

final class FetchPaymentsClientsSuccess extends FetchPaymentsClientsDataState {
  FetchPaymentsClientsSuccess({
    required super.payments,
    required super.hasMore,
  });
}

final class FetchPaymentsClientsLoadingMore
    extends FetchPaymentsClientsDataState {
  FetchPaymentsClientsLoadingMore({
    required super.payments,
    required super.hasMore,
  });
}

final class FetchPaymentsClientsLoadMoreError
    extends FetchPaymentsClientsDataState {
  final String failure;

  FetchPaymentsClientsLoadMoreError({
    required super.payments,
    required super.hasMore,
    required this.failure,
  });
}
