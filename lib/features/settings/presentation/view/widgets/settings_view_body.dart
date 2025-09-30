import 'package:debt_managment_app/features/settings/presentation/cubits/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_colors.dart';
import 'card_section.dart';
import 'TextHeaderSettings.dart';
import 'settings_tile.dart';
import 'package:day_night_switch/day_night_switch.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        const TextHeaderSettings('الحساب'),
        CardSection(
          children: [
            SettingsTile(
              title: 'معلومات الحساب',
              subtitle: 'mohammed@example.com',
              leadingIcon: Icons.person_outline,
              trailingWidget: Text('محمد السعدي'),
            ),
          ],
        ),

        SizedBox(height: 16),
        const TextHeaderSettings('التفضيلات'),
        CardSection(
          children: [
            const SettingsTile(
              title: 'اللغة',
              subtitle: 'العربية',
              leadingIcon: Icons.public,
            ),
            Divider(),
            SettingsTile(
              title: 'الثيم',
              subtitle: isDark ? 'داكن' : 'فاتح',
              leadingIcon: Icons.brightness_6_outlined,
              trailingWidget: CustomThemeModeSwitcher(),
            ),
          ],
        ),
        SizedBox(height: 16),
        const TextHeaderSettings('المساعدة والدعم'),
        CardSection(
          children: [
            SettingsTile(title: 'المساعدة', leadingIcon: Icons.help_outline),
            Divider(),
            SettingsTile(title: 'حول التطبيق', leadingIcon: Icons.info_outline),
          ],
        ),
        SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.logout),
          label: Text('تسجيل الخروج'),
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
        ),
        SizedBox(height: 12),
        Center(child: Text('سجلها الإصدار 1.0.0')),
      ],
    );
  }
}

class CustomThemeModeSwitcher extends StatelessWidget {
  const CustomThemeModeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        height: 20,
        width: 40,
        child: FittedBox(
          child: DayNightSwitch(
            value: context.watch<ThemeCubit>().state == ThemeMode.dark,
            dayColor: AppColors.primary.withOpacity(.6),
            onChanged: (value) {
              context.read<ThemeCubit>().setTheme(
                value ? ThemeMode.dark : ThemeMode.light,
              );
            },
          ),
        ),
      ),
    );
  }
}
