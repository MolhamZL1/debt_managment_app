part of 'add_debt_cubit.dart';

@immutable
sealed class AddDebtState {}

final class AddDebtInitial extends AddDebtState {}

final class AddDebtLoading extends AddDebtState {}

final class AddDebtSuccess extends AddDebtState {}

final class AddDebtError extends AddDebtState {
  final String errMessage;
  AddDebtError({required this.errMessage});
}
