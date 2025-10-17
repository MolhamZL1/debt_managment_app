part of 'fetch_clients_cubit.dart';

@immutable
sealed class FetchClientsState {}

final class FetchClientsInitial extends FetchClientsState {}

final class FetchClientsLoading extends FetchClientsState {}

final class FetchClientsSuccess extends FetchClientsState {
  final List<ClientEntity> clients;
  FetchClientsSuccess({required this.clients});
}

final class FetchClientsError extends FetchClientsState {
  final String failure;
  FetchClientsError({required this.failure});
}
