import 'package:debt_managment_app/core/utils/data.dart';
import 'package:debt_managment_app/features/settings/presentation/view/about_us_view.dart';
import 'package:debt_managment_app/features/settings/presentation/view/help_view.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
      padding: const EdgeInsets.all(12),
      children: [
        //  const TextHeaderSettings('الحساب'),

        // SettingsCardSection(
        //   children: [
        //     SettingsTile(
        //       title: 'معلومات الحساب',
        //       subtitle: 'محلي بدون تسجيل دخول',
        //       leadingIcon: Icons.person_outline,
        //       trailingWidget: const Text('وضع Offline'),
        //     ),
        //   ],
        // ),
        // const SizedBox(height: 16),
        const TextHeaderSettings('التفضيلات'),
        SettingsCardSection(
          children: [
            const SettingsTile(
              title: 'اللغة',
              subtitle: 'العربية',
              leadingIcon: Icons.public,
            ),
            const Divider(),
            SettingsTile(
              title: 'الثيم',
              subtitle: isDark ? 'داكن' : 'فاتح',
              leadingIcon: Icons.brightness_6_outlined,
              trailingWidget: const CustomThemeModeSwitcher(),
            ),
          ],
        ),

        const SizedBox(height: 16),
        const TextHeaderSettings('المساعدة والدعم'),
        SettingsCardSection(
          children: [
            GestureDetector(
              onTap: () {
                launchUrl(Uri.parse(Data.privacyPolicyUrl));
              },
              child: const SettingsTile(
                title: "سياسة الخصوصية",
                leadingIcon: Icons.privacy_tip_outlined,
              ),
            ),
            const Divider(),
            GestureDetector(
              onTap: () {
                launchUrl(Uri.parse(Data.termsAndConditionsUrl));
              },
              child: const SettingsTile(
                title: "الشروط و الاحكام",
                leadingIcon: Icons.gavel_outlined,
              ),
            ),
            const Divider(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, HelpPage.routename);
              },
              child: const SettingsTile(
                title: 'المساعدة',
                leadingIcon: Icons.help_outline,
              ),
            ),
            const Divider(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AboutUsPage.routename);
              },
              child: const SettingsTile(
                title: 'من نحن',
                leadingIcon: Icons.info_outline,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),
        const Center(child: Text('سجلها الإصدار 1.0.0')),
      ],
    );
  }
}
