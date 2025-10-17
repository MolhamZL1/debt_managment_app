part of 'fetch_payments_clients_cubit.dart';

@immutable
sealed class FetchPaymentsClientsState {}

final class FetchPaymentsClientsInitial extends FetchPaymentsClientsState {}

final class FetchPaymentsClientsLoading extends FetchPaymentsClientsState {}

final class FetchPaymentsClientsError extends FetchPaymentsClientsState {
  final String errMessage;
  FetchPaymentsClientsError({required this.errMessage});
}

final class FetchPaymentsClientsSuccess extends FetchPaymentsClientsState {
  final List<PaymentEntity> payments;
  FetchPaymentsClientsSuccess({required this.payments});
}
