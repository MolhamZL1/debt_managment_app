import 'package:debt_managment_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FilterChipsWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelected;
  final List<String> filters; // ✅ صارت بارامتر

  const FilterChipsWidget({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
    required this.filters, // ✅ لازم تمررها عند الاستدعاء
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: List.generate(filters.length, (index) {
          final isSelected = selectedIndex == index;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: GestureDetector(
              onTap: () => onSelected(index),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.background,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  filters[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
