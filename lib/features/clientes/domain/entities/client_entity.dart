class ClientEntity {
  final String id;
  final String name;
  final String? phoneNumber;
  final String? address;
  final String amount;
  final String? lastTransaction;

  ClientEntity({
    required this.id,
    required this.lastTransaction,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.amount,
  });
}

final List<ClientEntity> clients = [
  ClientEntity(
    id: "1",
    name: "أحمد محمد",
    phoneNumber: "+966501234567",
    address: "الرياض، حي الريس",
    lastTransaction: "1445/07/23 هـ",
    amount: "-5000",
  ),
  ClientEntity(
    id: "2",
    name: "سارة أحمد",
    phoneNumber: "+966501111111",
    address: "جدة",
    lastTransaction: "1445/07/28 هـ",
    amount: "-1200",
  ),
  ClientEntity(
    id: "3",
    name: "فاطمة علي",
    phoneNumber: "+966507654321",
    address: "مكة",
    lastTransaction: "1445/07/25 هـ",
    amount: "500",
  ),
];
