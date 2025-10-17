part of 'add_client_cubit.dart';

@immutable
sealed class AddClientState {}

final class AddClientInitial extends AddClientState {}

final class AddClientLoading extends AddClientState {}

final class AddClientSuccess extends AddClientState {}

final class AddClientFailure extends AddClientState {
  AddClientFailure(this.errorMessage);
  final String errorMessage;
}
