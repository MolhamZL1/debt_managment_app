import 'package:flutter/material.dart';

class SegmentedTabs extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const SegmentedTabs({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = ["الديون", "الدفعات", "كشف الحساب"];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(tabs.length, (index) {
        final isSelected = selectedIndex == index;

        return GestureDetector(
          onTap: () => onTap(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tabs[index],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.green : Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                height: 3,
                width: 60,
                color: isSelected ? Colors.green : Colors.transparent,
              ),
            ],
          ),
        );
      }),
    );
  }
}
