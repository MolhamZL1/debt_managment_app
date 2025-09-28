import 'package:debt_managment_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class StatsRow extends StatelessWidget {
  final double balance; // سالب = مدين
  final double totalPaid;
  final double totalDebts;

  const StatsRow({
    super.key,
    required this.balance,
    required this.totalPaid,
    required this.totalDebts,
  });

  Widget _item(String title, String value, {Color? color}) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyles.titleMedium.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final balColor = balance < 0 ? Color(0xFFE11D48) : Colors.green;
    return Row(
      children: [
        _item(
          "الرصيد",
          "ر.س ${balance.abs().toStringAsFixed(0)}",
          color: balColor,
        ),

        _item(
          "إجمالي المدفوع",
          "ر.س ${totalPaid.toStringAsFixed(0)}",
          color: Colors.green,
        ),

        _item(
          "إجمالي الديون",
          "ر.س ${totalDebts.toStringAsFixed(0)}",
          color: Color(0xFFE11D48),
        ),
      ],
    );
  }
}
