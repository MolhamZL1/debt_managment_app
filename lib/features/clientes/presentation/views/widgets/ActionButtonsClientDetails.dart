import 'package:flutter/material.dart';

class ActionButtonsClientDetails extends StatelessWidget {
  final VoidCallback onAddDebt;
  final VoidCallback onAddPayment;

  const ActionButtonsClientDetails({
    super.key,
    required this.onAddDebt,
    required this.onAddPayment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onAddDebt,
              icon: const Icon(Icons.add),
              label: const Text("إضافة دين"),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextButton.icon(
              onPressed: onAddPayment,
              icon: const Icon(Icons.add),
              label: const Text("تسجيل دفعة"),
            ),
          ),
        ],
      ),
    );
  }
}
