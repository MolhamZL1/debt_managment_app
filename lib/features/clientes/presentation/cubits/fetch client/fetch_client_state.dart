part of 'fetch_client_cubit.dart';

@immutable
sealed class FetchClientState {}

final class FetchClientInitial extends FetchClientState {}

final class FetchClientLoading extends FetchClientState {}

final class FetchClientSuccess extends FetchClientState {
  final ClientEntity clientEntity;
  FetchClientSuccess(this.clientEntity);
}

final class FetchClientError extends FetchClientState {
  final String message;
  FetchClientError(this.message);
}
