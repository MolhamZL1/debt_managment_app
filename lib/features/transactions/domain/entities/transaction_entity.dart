class TransactionEntity {
  final int id;
  final int clientId;
  final String clientName;
  final String date;
  final String? description;
  final double amount;
  final bool isDebt;

  TransactionEntity({
    required this.clientId,
    required this.isDebt,
    required this.id,
    required this.clientName,
    required this.date,
    required this.description,
    required this.amount,
  });
}
