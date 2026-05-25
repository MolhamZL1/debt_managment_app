import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../transactions/presentation/view/widgets/Transaction_Item_Card.dart';
import '../../../domain/entities/home_view_entity.dart';
import 'ClientsSummaryRow.dart';
import 'EmptyHomeStateSection.dart';
import 'HomeHeader.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key, required this.homeViewEntity});
  final HomeViewEntity homeViewEntity;

  @override
  Widget build(BuildContext context) {
    final hasRecentDebts = homeViewEntity.recentDebts.isNotEmpty;
    final hasRecentPayments = homeViewEntity.recentPayments.isNotEmpty;
    final hasAnyActivity = hasRecentDebts || hasRecentPayments;
    final l10n = S.of(context);

    return ListView(
      children: [
        HomeHeader(totalDebts: homeViewEntity.totalDebts),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClientsSummaryRow(
                totalClients: homeViewEntity.totalClients,
                indebtedCount: homeViewEntity.indebtedClients,
                nonIndebtedCount: homeViewEntity.nonIndebtedClients,
              ),
              const SizedBox(height: 8),

              if (!hasAnyActivity) const EmptyHomeStateSection(),

              if (hasRecentDebts) ...[
                Text(
                  l10n.recentDebts,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                ...homeViewEntity.recentDebts.map(
                  (tx) => TransactionDebtItem(tx: tx),
                ),
                const SizedBox(height: 8),
              ],

              if (hasRecentPayments) ...[
                Text(
                  l10n.recentPayments,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                ...homeViewEntity.recentPayments.map(
                  (tx) => TransactionPaymentItem(tx: tx),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
