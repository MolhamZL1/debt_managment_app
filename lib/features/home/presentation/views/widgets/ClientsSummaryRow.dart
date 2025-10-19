import 'package:flutter/material.dart';

import 'ClientSummaryItem.dart';

class ClientsSummaryRow extends StatelessWidget {
  final int totalClients;
  final int indebtedCount;
  final int nonIndebtedCount;

  const ClientsSummaryRow({
    super.key,
    required this.totalClients,
    required this.indebtedCount,
    required this.nonIndebtedCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClientSummaryItem(
            title: 'المدينون',
            value: indebtedCount,
            icon: Icons.trending_up_rounded,
            color: const Color(0xFFEF4444),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ClientSummaryItem(
            title: 'غير المدينون',
            value: nonIndebtedCount,
            icon: Icons.check_circle_rounded,
            color: const Color(0xFF22C55E),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ClientSummaryItem(
            title: 'إجمالي',
            value: totalClients,
            icon: Icons.group_rounded,
            color: const Color(0xFF3B82F6),
          ),
        ),
      ],
    );
  }
}
