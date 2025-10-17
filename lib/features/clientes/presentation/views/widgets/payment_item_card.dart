import 'package:debt_managment_app/core/entities/payment_entity.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class PaymentItemCard extends StatelessWidget {
  final PaymentEntity paymentEntity;

  const PaymentItemCard({super.key, required this.paymentEntity});

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
                      color: Color(0xFFE9F8F5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      "${paymentEntity.amount} ر.س دفعة",
                      style: TextStyle(color: AppColors.success),
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
                      Text(paymentEntity.date),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(paymentEntity.description ?? ""),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
