class PaymentEntity {
  final int id;
  final String? description;
  final double amount;
  final String date;

  PaymentEntity({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
  });
}
