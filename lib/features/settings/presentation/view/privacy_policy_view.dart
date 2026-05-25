import 'package:debt_managment_app/core/theme/app_colors.dart';
import 'package:debt_managment_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});
  static const String routename = '/privacy_policy';

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return _PolicyScaffold(
      title: l10n.privacyPolicy,
      icon: Icons.privacy_tip_outlined,
      intro: l10n.privacyIntro,
      items: [
        _PolicyItem(title: l10n.localStorage, body: l10n.localStorageBody),
        _PolicyItem(title: l10n.noLogin, body: l10n.noLoginBody),
        _PolicyItem(
          title: l10n.backupResponsibility,
          body: l10n.backupResponsibilityBody,
        ),
      ],
    );
  }
}

class _PolicyScaffold extends StatelessWidget {
  const _PolicyScaffold({
    required this.title,
    required this.icon,
    required this.intro,
    required this.items,
  });

  final String title;
  final IconData icon;
  final String intro;
  final List<_PolicyItem> items;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(.10),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.primary.withOpacity(.18)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 27,
                  backgroundColor: AppColors.primary,
                  child: Icon(icon, color: Colors.white),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    intro,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.55,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...items.map(
            (item) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.cardDark : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color:
                      isDark
                          ? Colors.white.withOpacity(.08)
                          : Colors.black.withOpacity(.05),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.body,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark ? Colors.white70 : AppColors.textGrey,
                      height: 1.55,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PolicyItem {
  const _PolicyItem({required this.title, required this.body});

  final String title;
  final String body;
}
