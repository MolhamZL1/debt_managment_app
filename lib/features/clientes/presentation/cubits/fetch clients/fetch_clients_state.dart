part of 'fetch_clients_cubit.dart';

@immutable
sealed class FetchClientsState {}

final class FetchClientsInitial extends FetchClientsState {}

final class FetchClientsLoading extends FetchClientsState {}

sealed class FetchClientsDataState extends FetchClientsState {
  final List<ClientEntity> clients;
  final bool hasMore;

  FetchClientsDataState({required this.clients, required this.hasMore});
}

final class FetchClientsSuccess extends FetchClientsDataState {
  FetchClientsSuccess({required super.clients, required super.hasMore});
}

final class FetchClientsLoadingMore extends FetchClientsDataState {
  FetchClientsLoadingMore({required super.clients, required super.hasMore});
}

final class FetchClientsLoadMoreError extends FetchClientsDataState {
  final String failure;

  FetchClientsLoadMoreError({
    required super.clients,
    required super.hasMore,
    required this.failure,
  });
}

final class FetchClientsError extends FetchClientsState {
  final String failure;
  FetchClientsError({required this.failure});
}
