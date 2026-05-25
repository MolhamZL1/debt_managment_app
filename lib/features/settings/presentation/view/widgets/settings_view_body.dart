import 'package:debt_managment_app/core/theme/app_colors.dart';
import 'package:debt_managment_app/features/settings/presentation/view/about_us_view.dart';
import 'package:debt_managment_app/features/settings/presentation/view/help_view.dart';
import 'package:debt_managment_app/features/settings/presentation/view/privacy_policy_view.dart';
import 'package:debt_managment_app/features/settings/presentation/view/terms_and_conditions_view.dart';
import 'package:debt_managment_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/language/language_cubit.dart';
import 'CustomThemeModeSwitcher.dart';
import 'SettingsCardSection.dart';
import 'TextHeaderSettings.dart';
import 'settings_tile.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = S.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      children: [
        TextHeaderSettings(l10n.settingsAppSection),
        SettingsCardSection(
          children: [
            SettingsTile(
              title: l10n.language,
              subtitle: l10n.languageSubtitle,
              leadingIcon: Icons.language_rounded,
              accentColor: const Color(0xFF2563EB),
              onTap: () => _showLanguageDialog(context),
              trailingWidget: _LanguageStatusChip(
                language: context.watch<LanguageCubit>().currentLanguage,
              ),
            ),
            const _SettingsDivider(),
            SettingsTile(
              title: l10n.appearance,
              subtitle: isDark ? l10n.darkModeEnabled : l10n.lightModeEnabled,
              leadingIcon: Icons.brightness_6_rounded,
              accentColor: const Color(0xFFF59E0B),
              trailingWidget: const CustomThemeModeSwitcher(),
            ),
          ],
        ),
        const SizedBox(height: 22),
        TextHeaderSettings(l10n.settingsHelpSection),
        SettingsCardSection(
          children: [
            SettingsTile(
              title: l10n.help,
              subtitle: l10n.helpSubtitle,
              leadingIcon: Icons.help_outline_rounded,
              accentColor: const Color(0xFF16A34A),
              onTap: () => Navigator.pushNamed(context, HelpPage.routename),
            ),
            const _SettingsDivider(),
            SettingsTile(
              title: l10n.aboutUs,
              subtitle: l10n.aboutUsSubtitle,
              leadingIcon: Icons.info_outline_rounded,
              accentColor: const Color(0xFF7C3AED),
              onTap: () => Navigator.pushNamed(context, AboutUsPage.routename),
            ),
            const _SettingsDivider(),
            SettingsTile(
              title: l10n.privacyPolicy,
              subtitle: l10n.privacyPolicySubtitle,
              leadingIcon: Icons.privacy_tip_outlined,
              accentColor: const Color(0xFF0891B2),
              onTap:
                  () =>
                      Navigator.pushNamed(context, PrivacyPolicyView.routename),
            ),
            const _SettingsDivider(),
            SettingsTile(
              title: l10n.termsAndConditions,
              subtitle: l10n.termsAndConditionsSubtitle,
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
            l10n.versionLabel,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isDark ? Colors.white54 : AppColors.textGrey,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showLanguageDialog(BuildContext context) {
    final l10n = S.of(context);
    final languageCubit = context.read<LanguageCubit>();

    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder:
          (sheetContext) => BlocProvider.value(
            value: languageCubit,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.languageDialogTitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _LanguageOptionTile(
                      language: AppLanguage.ar,
                      title: l10n.languageArabic,
                    ),
                    _LanguageOptionTile(
                      language: AppLanguage.en,
                      title: l10n.languageEnglish,
                    ),
                    _LanguageOptionTile(
                      language: AppLanguage.system,
                      title: l10n.languageSystem,
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}

class _LanguageStatusChip extends StatelessWidget {
  const _LanguageStatusChip({required this.language});

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

class _LanguageOptionTile extends StatelessWidget {
  const _LanguageOptionTile({required this.language, required this.title});

  final AppLanguage language;
  final String title;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<LanguageCubit>();
    final isSelected = cubit.currentLanguage == language;

    return RadioListTile<AppLanguage>(
      value: language,
      groupValue: cubit.currentLanguage,
      title: Text(title),
      secondary: Icon(
        language == AppLanguage.system
            ? Icons.phone_iphone_rounded
            : Icons.translate_rounded,
      ),
      selected: isSelected,
      onChanged: (value) {
        if (value == null) return;
        context.read<LanguageCubit>().setLanguage(value);
        Navigator.pop(context);
      },
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
