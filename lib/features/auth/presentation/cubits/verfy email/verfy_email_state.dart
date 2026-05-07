part of 'verfy_email_cubit.dart';

@immutable
sealed class VerfyEmailState {}

final class VerfyEmailInitial extends VerfyEmailState {}

final class VerfyEmailSucces extends VerfyEmailState {}

final class VerfyEmailFailure extends VerfyEmailState {
  final String message;

  VerfyEmailFailure({required this.message});
}

final class VerfyEmailLoading extends VerfyEmailState {}
