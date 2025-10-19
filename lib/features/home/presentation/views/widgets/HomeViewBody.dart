import 'package:flutter/material.dart';

import '../../../../transactions/presentation/view/widgets/Transaction_Item_Card.dart';
import '../../../domain/entities/home_view_entity.dart';
import 'ClientsSummaryRow.dart';
import 'HomeHeader.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key, required this.homeViewEntity});
  final HomeViewEntity homeViewEntity;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HomeHeader(totalDebts: homeViewEntity.totalDebts),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClientsSummaryRow(
                  totalClients: homeViewEntity.totalClients,
                  indebtedCount: homeViewEntity.indebtedClients,
                  nonIndebtedCount: homeViewEntity.nonIndebtedClients,
                ),
                SizedBox(height: 8),
                Text(
                  'اخر الديون',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ...List.generate(
                  homeViewEntity.recentDebts.length,
                  (index) => TransactionDebtItem(
                    tx: homeViewEntity.recentDebts[index],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'اخر الدفعات',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ...List.generate(
                  homeViewEntity.recentDebts.length,
                  (index) => TransactionPaymentItem(
                    tx: homeViewEntity.recentDebts[index],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
