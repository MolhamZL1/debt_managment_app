import 'package:debt_managment_app/core/theme/app_colors.dart';
import 'package:debt_managment_app/features/settings/presentation/view/about_us_view.dart';
import 'package:debt_managment_app/features/settings/presentation/view/help_view.dart';
import 'package:debt_managment_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/utils/data.dart';
import '../../cubits/currency/currency_cubit.dart';
import '../../cubits/language/language_cubit.dart';
import 'CustomThemeModeSwitcher.dart';
import 'LanguageDialog.dart';
import 'LanguageStatusChip.dart';
import 'SettingsCardSection.dart';
import 'SettingsDivider.dart';
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
              onTap:
                  () => showModalBottomSheet(
                    context: context,
                    builder: (sheetcontext) => const LanguageDialog(),
                  ),
              trailingWidget: LanguageStatusChip(
                language: context.watch<LanguageCubit>().currentLanguage,
              ),
            ),
            const SettingsDivider(),
            SettingsTile(
              title:
                  Localizations.localeOf(context).languageCode == 'ar'
                      ? 'العملة الافتراضية'
                      : 'Default currency',
              subtitle:
                  Localizations.localeOf(context).languageCode == 'ar'
                      ? 'تغيير رمز العملة المعروض بجانب المبالغ'
                      : 'Change the currency shown beside amounts',
              leadingIcon: Icons.payments_outlined,
              accentColor: const Color(0xFF0891B2),
              onTap: () => _showCurrencyDialog(context),
              trailingWidget: _CurrencyStatusChip(
                currency: context.watch<CurrencyCubit>().state,
              ),
            ),
            const SettingsDivider(),
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
            const SettingsDivider(),
            SettingsTile(
              title: l10n.aboutUs,
              subtitle: l10n.aboutUsSubtitle,
              leadingIcon: Icons.info_outline_rounded,
              accentColor: const Color(0xFF16A34A),
              onTap: () => Navigator.pushNamed(context, AboutUsPage.routename),
            ),
            const SettingsDivider(),
            SettingsTile(
              title: l10n.privacyPolicy,
              subtitle: l10n.privacyPolicySubtitle,
              leadingIcon: Icons.privacy_tip_outlined,
              accentColor: const Color(0xFF16A34A),
              onTap: () => launchUrl(Uri.parse(Data.privacyPolicyUrl)),
            ),
            const SettingsDivider(),
            SettingsTile(
              title: l10n.termsAndConditions,
              subtitle: l10n.termsAndConditionsSubtitle,
              leadingIcon: Icons.gavel_outlined,
              accentColor: const Color(0xFF16A34A),
              onTap: () => launchUrl(Uri.parse(Data.termsAndConditionsUrl)),
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

  Future<void> _showCurrencyDialog(BuildContext context) {
    final currencyCubit = context.read<CurrencyCubit>();
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder:
          (sheetContext) => BlocProvider.value(
            value: currencyCubit,
            child: SafeArea(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.sizeOf(context).height * .72,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isArabic ? 'اختر العملة الافتراضية' : 'Choose currency',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 8),
                      Flexible(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: AppCurrency.values.length,
                          separatorBuilder:
                              (context, index) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            return _CurrencyOptionTile(
                              currency: AppCurrency.values[index],
                              isArabic: isArabic,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }
}

class _CurrencyStatusChip extends StatelessWidget {
  const _CurrencyStatusChip({required this.currency});

  final AppCurrency currency;

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
        currency.code,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: isDark ? Colors.white : AppColors.primary,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _CurrencyOptionTile extends StatelessWidget {
  const _CurrencyOptionTile({required this.currency, required this.isArabic});

  final AppCurrency currency;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final currentCurrency = context.watch<CurrencyCubit>().state;

    return InkWell(
      onTap: () {
        context.read<CurrencyCubit>().setCurrency(currency);
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Radio<AppCurrency>(
              value: currency,
              groupValue: currentCurrency,
              onChanged: (value) {
                if (value == null) return;
                context.read<CurrencyCubit>().setCurrency(value);
                Navigator.pop(context);
              },
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currency.displayName(isArabic ? 'ar' : 'en'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${currency.code} · ${currency.symbol}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white60
                              : AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
