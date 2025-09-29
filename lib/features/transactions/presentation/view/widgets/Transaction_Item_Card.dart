import 'package:flutter/material.dart';

class TransactionItemCard extends StatelessWidget {
  final String clientName;
  final String date;
  final String description;
  final double amount;
  final bool isPayment; // true = دفعة, false = دين
  final String? invoiceNo;
  final String? dueDate;

  const TransactionItemCard({
    super.key,
    required this.clientName,
    required this.date,
    required this.description,
    required this.amount,
    required this.isPayment,
    this.invoiceNo,
    this.dueDate,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isPayment ? Colors.green[50] : Colors.red[50];
    final textColor = isPayment ? Colors.green : Colors.red;
    final icon = isPayment ? Icons.arrow_downward : Icons.arrow_upward;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // الأيقونة
          CircleAvatar(
            backgroundColor: bgColor,
            child: Icon(icon, color: textColor),
          ),
          const SizedBox(width: 12),

          // تفاصيل العميل
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clientName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(description, style: const TextStyle(fontSize: 12)),
                ],
                if (dueDate != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    "استحقاق: $dueDate",
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
                if (invoiceNo != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    "فاتورة رقم $invoiceNo",
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(width: 12),

          // المبلغ
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "${amount.toStringAsFixed(0)} ر.س ${isPayment ? "دفعة" : "دين"}",
              style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
