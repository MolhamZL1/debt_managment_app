import 'package:debt_managment_app/core/theme/App_themes.dart';
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import '../../../../../core/theme/app_colors.dart';
// عدّل المسار حسب مشروعك

class ThemeToggleAction extends StatelessWidget {
  const ThemeToggleAction({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ThemeSwitcher(
      builder: (context) {
        return CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.background,
          child: IconButton(
            tooltip: isDark ? 'الوضع الفاتح' : 'الوضع الداكن',
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: AppColors.primary,
            ),
            onPressed: () {
              final nextTheme =
                  isDark ? AppTheme.lightTheme : AppTheme.darkTheme;
              ThemeSwitcher.of(context).changeTheme(theme: nextTheme);
            },
          ),
        );
      },
    );
  }
}
