import 'package:debt_managment_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class DebtItemCard extends StatelessWidget {
  final Debt debt;
  final VoidCallback onDelete;

  const DebtItemCard({
    super.key,
    required this.debt,
    required this.onDelete,
    required Null Function() onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      "دين • ر.س ${debt.amount.toStringAsFixed(0)}",
                      style: const TextStyle(color: AppColors.error),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.black87,
                      ),
                      Text(
                        "استحقاق: ${debt.dueHijri}",
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                  Text(
                    "  فاتورة رقم ${debt.invoiceNo}",
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ),
            ),
            const Icon(Icons.receipt_long_outlined, color: AppColors.primary),

            const SizedBox(width: 12),
            InkWell(
              onTap: onDelete,
              child: const Icon(
                Icons.delete_outline,
                size: 18,
                color: AppColors.error,
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}

class Debt {
  final double amount;
  final String dueHijri;
  final String invoiceNo;
  Debt({required this.amount, required this.dueHijri, required this.invoiceNo});
}
