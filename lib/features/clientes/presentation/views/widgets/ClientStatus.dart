import 'package:debt_managment_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class ClientStatus extends StatelessWidget {
  final double balance;

  const ClientStatus({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    final isDebt = balance < 0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color:
                isDebt
                    ? AppColors.error.withAlpha(50)
                    : AppColors.success.withAlpha(50),
            borderRadius: BorderRadius.circular(16),
          ),
          child:
              isDebt
                  ? const Text("مدين", style: TextStyle(color: AppColors.error))
                  : const Text(
                    "غير مدين",
                    style: TextStyle(color: AppColors.primary),
                  ),
        ),
        Spacer(),
        isDebt
            ? _item(
              "الديون",
              "ل.س ${balance.abs().toStringAsFixed(0)}",
              color: Color(0xFFE11D48),
            )
            : _item(
              "الرصيد",
              "ل.س ${balance.abs().toStringAsFixed(0)}",
              color: Colors.green,
            ),
      ],
    );
  }

  Widget _item(String title, String value, {Color? color}) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.titleMedium.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(color: Colors.black54)),
      ],
    );
  }
}
