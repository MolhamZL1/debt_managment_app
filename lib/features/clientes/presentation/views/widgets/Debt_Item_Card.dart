import 'package:debt_managment_app/core/entities/debt_entity.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class DebtItemCard extends StatelessWidget {
  final DebtEntity debtEntity;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const DebtItemCard({
    super.key,
    required this.debtEntity,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFFCE7EF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      "${debtEntity.amount} ر.س دين",
                      style: TextStyle(color: AppColors.error),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        size: 20,
                        color:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.grey.shade600
                                : Colors.grey.shade300,
                      ),
                      const SizedBox(width: 4),
                      Text(debtEntity.date),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(debtEntity.description),
                ],
              ),
            ),
            // IconButton(
            //   onPressed: onEdit,
            //   icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
            // ),
            // const SizedBox(width: 8),
            // IconButton(
            //   onPressed: onDelete,
            //   icon: const Icon(
            //     Icons.delete_outline,
            //     size: 18,
            //     color: AppColors.error,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
