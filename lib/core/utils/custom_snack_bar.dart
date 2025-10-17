import 'package:debt_managment_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

void customshowSnackBar(BuildContext context, {required String massege}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        massege,
        style: const TextStyle(color: Colors.black),
        textAlign: TextAlign.end,
      ),
      backgroundColor: AppColors.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      duration: const Duration(milliseconds: 1000),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.only(bottom: 60, left: 64, right: 64),
    ),
  );
}
