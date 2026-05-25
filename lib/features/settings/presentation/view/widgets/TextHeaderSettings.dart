import 'package:debt_managment_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TextHeaderSettings extends StatelessWidget {
  final String title;
  const TextHeaderSettings(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 4, end: 4, bottom: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
