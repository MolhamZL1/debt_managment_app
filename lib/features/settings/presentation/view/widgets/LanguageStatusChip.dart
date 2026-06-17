import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../cubits/language/language_cubit.dart';

class LanguageStatusChip extends StatelessWidget {
  const LanguageStatusChip({required this.language});

  final AppLanguage language;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final label = switch (language) {
      AppLanguage.ar => 'AR',
      AppLanguage.en => 'EN',
      AppLanguage.system => 'AUTO',
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color:
            isDark
                ? Colors.white.withOpacity(.08)
                : AppColors.primary.withOpacity(.09),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: isDark ? Colors.white : AppColors.primary,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
