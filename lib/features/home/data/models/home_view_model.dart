import 'package:debt_managment_app/features/home/domain/entities/home_view_entity.dart';
import 'package:debt_managment_app/features/transactions/data/models/transaction_model.dart';

import '../../../transactions/domain/entities/transaction_entity.dart';

class HomeViewModel {
  final double totalDebts;
  final int totalClients;
  final int indebtedClients;
  final int nonIndebtedClients;
  final List<TransactionModel> recentDebts;
  final List<TransactionModel> recentPayments;

  HomeViewModel({
    required this.totalDebts,
    required this.totalClients,
    required this.indebtedClients,
    required this.nonIndebtedClients,
    required this.recentDebts,
    required this.recentPayments,
  });
  factory HomeViewModel.fromJson(Map<String, dynamic> json) {
    return HomeViewModel(
      totalDebts: json['balance'],
      totalClients: json["clients_count"],
      indebtedClients: json['clients_in_debt'],
      nonIndebtedClients: json['clients_clear'],
      recentDebts: List<TransactionModel>.from(
        json["recent_debts"].map((e) => TransactionModel.fromJson(e)),
      ),
      recentPayments: List<TransactionModel>.from(
        json["recent_payments"].map((e) => TransactionModel.fromJson(e)),
      ),
    );
  }
  toEntity() {
    return HomeViewEntity(
      totalDebts: totalDebts,
      totalClients: totalClients,
      indebtedClients: indebtedClients,
      nonIndebtedClients: nonIndebtedClients,
      recentDebts:
          recentDebts.map<TransactionEntity>((e) => e.toEntity()).toList(),
      recentPayments:
          recentPayments.map<TransactionEntity>((e) => e.toEntity()).toList(),
    );
  }
}
