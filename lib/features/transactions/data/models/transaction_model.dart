import 'package:debt_managment_app/features/transactions/domain/entities/transaction_entity.dart';

class TransactionModel {
  final int id;
  final int clientId;
  final String clientName;
  final String date;
  final String? description;
  final double amount;
  final bool isDebt;

  TransactionModel({
    required this.clientId,
    required this.id,
    required this.clientName,
    required this.date,
    required this.description,
    required this.amount,
    required this.isDebt,
  });
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json["id"],
      clientId: json["client_id"],
      clientName: json["client"]["name"],
      date: json["date"],
      description: json["description"],
      amount: double.parse(json["amount"]),
      isDebt: json["type"] == "debt",
    );
  }
  toEntity() {
    return TransactionEntity(
      id: id,
      clientId: clientId,
      clientName: clientName,
      date: date,
      description: description,
      amount: amount,
      isDebt: isDebt,
    );
  }
}
