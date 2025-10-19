import 'package:debt_managment_app/features/transactions/domain/entities/transaction_entity.dart';

class HomeViewEntity {
  final double totalDebts;
  final int totalClients;
  final int indebtedClients;
  final int nonIndebtedClients;
  final List<TransactionEntity> recentDebts;
  final List<TransactionEntity> recentPayments;

  HomeViewEntity({
    required this.totalDebts,
    required this.totalClients,
    required this.indebtedClients,
    required this.nonIndebtedClients,
    required this.recentDebts,
    required this.recentPayments,
  });
}
