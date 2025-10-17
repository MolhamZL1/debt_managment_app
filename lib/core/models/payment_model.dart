import '../entities/payment_entity.dart';

class PaymentModel {
  final int id;
  final String? description;
  final double amount;
  final String date;

  PaymentModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'notes': description,
      'amount': amount,
      'payment_date': date,
    };
  }

  factory PaymentModel.fromJson(Map<String, dynamic> map) {
    return PaymentModel(
      id: map['id'] as int,
      description: map['notes'] as String?,
      amount: double.parse(map['amount']),
      date: map['payment_date'] as String,
    );
  }
  factory PaymentModel.fromEntity(PaymentEntity entity) {
    return PaymentModel(
      id: entity.id,
      description: entity.description,
      amount: entity.amount,
      date: entity.date,
    );
  }
  PaymentEntity toEntity() {
    return PaymentEntity(
      id: id,
      description: description,
      amount: amount,
      date: date,
    );
  }
}
