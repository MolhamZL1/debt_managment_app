import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import 'ThemeToggleAction.dart';
import 'card_section.dart';
import 'section_header.dart';
import 'settings_tile.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        const SectionHeader('الحساب'),
        CardSection(
          children: [
            SettingsTile(
              title: 'معلومات الحساب',
              subtitle: 'mohammed@example.com',
              trailingIcon: Icons.person_outline,
              leading: Text(
                'محمد السعدي',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ],
        ),

        SizedBox(height: 16),
        const SectionHeader('التفضيلات'),
        CardSection(
          children: [
            const SettingsTile(
              title: 'اللغة',
              subtitle: 'العربية',
              trailingIcon: Icons.public,
            ),
            const Divider(),
            SettingsTile(
              title: 'الثيم',
              subtitle: isDark ? 'داكن' : 'فاتح',
              trailingWidget: const ThemeToggleAction(),
            ),
          ],
        ),
        SizedBox(height: 16),
        const SectionHeader('المساعدة والدعم'),
        const CardSection(
          children: [
            SettingsTile(title: 'المساعدة', trailingIcon: Icons.help_outline),
            Divider(),
            SettingsTile(
              title: 'حول التطبيق',
              trailingIcon: Icons.info_outline,
            ),
          ],
        ),

        SizedBox(height: 24),
        SizedBox(
          height: 48,
          child: ElevatedButton.icon(
            onPressed: null, // ❌ مافي لوجيك حالياً
            icon: Icon(Icons.logout),
            label: Text('تسجيل الخروج'),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
          ),
        ),
        SizedBox(height: 12),
        Center(
          child: Text(
            'سجلها الإصدار 1.0.0',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
      ],
    );
  }
}
