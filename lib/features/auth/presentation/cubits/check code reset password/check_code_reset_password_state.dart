part of 'check_code_reset_password_cubit.dart';

@immutable
sealed class CheckCodeResetPasswordState {}

final class CheckCodeResetPasswordInitial extends CheckCodeResetPasswordState {}

final class CheckCodeResetPasswordLoading extends CheckCodeResetPasswordState {}

final class CheckCodeResetPasswordSuccess extends CheckCodeResetPasswordState {}

final class CheckCodeResetPasswordFailure extends CheckCodeResetPasswordState {
  final String errorMessage;
  CheckCodeResetPasswordFailure({required this.errorMessage});
}
