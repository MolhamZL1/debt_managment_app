import 'package:intl/intl.dart';

class DebtEntity {
  final int id;
  final String? description;
  final double amount;
  final String date;

  DebtEntity({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
  });
  getFormattedAmount() {
    final formattedAmount = NumberFormat.compact(
      locale: 'ar',
    ).format(amount.abs());
    return formattedAmount;
  }
}
