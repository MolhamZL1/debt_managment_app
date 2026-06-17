import 'package:debt_managment_app/features/settings/presentation/cubits/currency/currency_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String selectedCurrencySymbol(BuildContext context) {
  return context.watch<CurrencyCubit>().state.symbol;
}

String formatCurrency(
  BuildContext context,
  num amount, {
  bool approximate = false,
}) {
  final prefix = approximate ? '~' : '';
  return '$prefix$amount ${selectedCurrencySymbol(context)}';
}
