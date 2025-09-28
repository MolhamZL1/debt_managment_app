import 'package:debt_managment_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSerchTextFaild extends StatelessWidget {
  // final TextEditingController controller;
  // final ValueChanged<String> onChanged;
  final String hintText;

  const CustomSerchTextFaild({
    super.key,
    // required this.controller,
    // required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        // controller: controller,
        // onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: AppColors.background,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
