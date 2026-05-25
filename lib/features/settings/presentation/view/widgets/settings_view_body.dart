import 'package:debt_managment_app/core/theme/app_colors.dart';
import 'package:debt_managment_app/features/settings/presentation/view/about_us_view.dart';
import 'package:debt_managment_app/features/settings/presentation/view/help_view.dart';
import 'package:debt_managment_app/features/settings/presentation/view/privacy_policy_view.dart';
import 'package:debt_managment_app/features/settings/presentation/view/terms_and_conditions_view.dart';
import 'package:flutter/material.dart';

import 'CustomThemeModeSwitcher.dart';
import 'SettingsCardSection.dart';
import 'TextHeaderSettings.dart';
import 'settings_tile.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      children: [
        const TextHeaderSettings('التطبيق'),
        SettingsCardSection(
          children: [
            const SettingsTile(
              title: 'اللغة',
              subtitle: 'العربية',
              leadingIcon: Icons.language_rounded,
              accentColor: Color(0xFF2563EB),
              trailingWidget: _StatusChip(label: 'AR'),
            ),
            const _SettingsDivider(),
            SettingsTile(
              title: 'المظهر',
              subtitle: isDark ? 'الوضع الداكن مفعل' : 'الوضع الفاتح مفعل',
              leadingIcon: Icons.brightness_6_rounded,
              accentColor: const Color(0xFFF59E0B),
              trailingWidget: const CustomThemeModeSwitcher(),
            ),
          ],
        ),
        const SizedBox(height: 22),
        const TextHeaderSettings('المساعدة والمعلومات'),
        SettingsCardSection(
          children: [
            SettingsTile(
              title: 'المساعدة',
              subtitle: 'خطوات الاستخدام والتواصل مع الدعم',
              leadingIcon: Icons.help_outline_rounded,
              accentColor: const Color(0xFF16A34A),
              onTap: () => Navigator.pushNamed(context, HelpPage.routename),
            ),
            const _SettingsDivider(),
            SettingsTile(
              title: 'من نحن',
              subtitle: 'فكرة التطبيق ورسالتنا ومعلومات التواصل',
              leadingIcon: Icons.info_outline_rounded,
              accentColor: const Color(0xFF7C3AED),
              onTap: () => Navigator.pushNamed(context, AboutUsPage.routename),
            ),
            const _SettingsDivider(),
            SettingsTile(
              title: 'سياسة الخصوصية',
              subtitle: 'كيف يحافظ التطبيق على بياناتك محليًا',
              leadingIcon: Icons.privacy_tip_outlined,
              accentColor: const Color(0xFF0891B2),
              onTap:
                  () =>
                      Navigator.pushNamed(context, PrivacyPolicyView.routename),
            ),
            const _SettingsDivider(),
            SettingsTile(
              title: 'الشروط والأحكام',
              subtitle: 'قواعد الاستخدام والمسؤولية',
              leadingIcon: Icons.gavel_rounded,
              accentColor: const Color(0xFFDC2626),
              onTap:
                  () => Navigator.pushNamed(
                    context,
                    TermsAndConditionsView.routename,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Center(
          child: Text(
            'سجّلها الإصدار 1.0.0',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isDark ? Colors.white54 : AppColors.textGrey,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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

class _SettingsDivider extends StatelessWidget {
  const _SettingsDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      indent: 72,
      endIndent: 14,
      color:
          Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withOpacity(.07)
              : Colors.black.withOpacity(.06),
    );
  }
}
