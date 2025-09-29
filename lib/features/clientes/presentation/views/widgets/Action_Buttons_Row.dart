import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class ActionButtonsRow extends StatelessWidget {
  final VoidCallback onAddDebt;
  final VoidCallback onAddPayment;

  const ActionButtonsRow({
    super.key,
    required this.onAddDebt,
    required this.onAddPayment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onAddDebt,
              icon: const Icon(Icons.add),
              label: const Text("إضافة دين"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onAddPayment,
              icon: const Icon(Icons.add),
              label: const Text("تسجيل دفعة"),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
                foregroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
