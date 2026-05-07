part of 'delete_client_cubit.dart';

@immutable
sealed class DeleteClientState {}

final class DeleteClientInitial extends DeleteClientState {}

final class DeleteClientLoading extends DeleteClientState {}

final class DeleteClientSuccess extends DeleteClientState {}

final class DeleteClientError extends DeleteClientState {
  final String message;

  DeleteClientError({required this.message});
}
