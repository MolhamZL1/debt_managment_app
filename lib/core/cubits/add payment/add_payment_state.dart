part of 'add_payment_cubit.dart';

@immutable
sealed class AddPaymentState {}

final class AddPaymentInitial extends AddPaymentState {}

final class AddPaymentSuccess extends AddPaymentState {}

final class AddPaymentLoading extends AddPaymentState {}

final class AddPaymentError extends AddPaymentState {
  final String errMessage;
  AddPaymentError(this.errMessage);
}
