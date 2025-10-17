import '../entities/debt_entity.dart';

class DebtModel {
  final int id;
  final String description;
  final double amount;
  final String date;

  DebtModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'amount': amount,
      'debt_date': date,
    };
  }

  factory DebtModel.fromJson(Map<String, dynamic> map) {
    return DebtModel(
      id: map['id'] as int,
      description: map['description'] as String,
      amount: double.parse(map['amount']),
      date: map['debt_date'] as String,
    );
  }
  factory DebtModel.fromEntity(DebtEntity entity) {
    return DebtModel(
      id: entity.id,
      description: entity.description,
      amount: entity.amount,
      date: entity.date,
    );
  }
  DebtEntity toEntity() {
    return DebtEntity(
      id: id,
      description: description,
      amount: amount,
      date: date,
    );
  }
}
