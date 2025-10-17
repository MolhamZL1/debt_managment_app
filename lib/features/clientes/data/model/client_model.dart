import '../../domain/entities/client_entity.dart';

class ClientModel {
  final int id;
  final String name;
  final String? phoneNumber;
  final String? address;
  final num amount;
  final String? lastTransaction;

  ClientModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.amount,
    required this.lastTransaction,
  });
  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'] as int,
      name: json['name'] as String,
      phoneNumber: json['phone'] as String?,
      address: json['address'] as String?,
      amount: json['remaining'] as num,
      lastTransaction: json['last_transaction_date'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phoneNumber,
      'address': address,
      'remaining': amount,
      'last_transaction_date': lastTransaction,
    };
  }

  ClientEntity toEntity() {
    return ClientEntity(
      id: id,
      name: name,
      phoneNumber: phoneNumber,
      address: address,
      amount: amount.toDouble(),
      lastTransaction: lastTransaction,
    );
  }
}
