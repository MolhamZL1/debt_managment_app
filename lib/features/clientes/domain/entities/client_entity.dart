class ClientEntity {
  final int id;
  final String name;
  final String? phoneNumber;
  final String? address;
  final double amount;
  final String? lastTransaction;

  ClientEntity({
    required this.id,
    required this.lastTransaction,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.amount,
  });
  bool isDebt() => amount > 0;
}
