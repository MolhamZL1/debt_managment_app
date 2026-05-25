import 'package:debt_managment_app/core/theme/app_colors.dart';
import 'package:debt_managment_app/core/utils/app_images.dart';
import 'package:debt_managment_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBrand {
  static const String email = 'molhamsa49@gmail.com';
  static const String whatsapp = '+963 988159532';
  static const String version = '1.0.0';
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});
  static const String routename = '/about_us';

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.aboutUs)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          const _AboutHero(),
          const SizedBox(height: 16),
          _SectionCard(
            title: l10n.ourMission,
            icon: Icons.flag_outlined,
            child: Text(
              l10n.brandMission,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.6,
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white70
                        : AppColors.textGrey,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _SectionCard(
            title: l10n.whatMakesAppDifferent,
            icon: Icons.workspace_premium_outlined,
            child: Column(
              children:
                  [
                    l10n.brandValuePrivacy,
                    l10n.brandValueArabicUi,
                    l10n.brandValueOffline,
                    l10n.brandValueClearNumbers,
                  ].map((value) => _ValueRow(value: value)).toList(),
            ),
          ),
          const SizedBox(height: 12),
          _SectionCard(
            title: l10n.contactUs,
            icon: Icons.contact_support_outlined,
            child: Column(
              children: [
                _ContactButton(
                  icon: Icons.email_outlined,
                  label: AppBrand.email,
                  onTap: () => launchUrl(Uri.parse('mailto:${AppBrand.email}')),
                ),
                const SizedBox(height: 8),
                _ContactButton(
                  icon: Icons.chat_outlined,
                  label: '${l10n.whatsapp} ${AppBrand.whatsapp}',
                  onTap:
                      () => launchUrl(
                        Uri.parse('https://wa.me/${AppBrand.whatsapp}'),
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              '${l10n.versionShort} ${AppBrand.version}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white54
                        : AppColors.textGrey,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutHero extends StatelessWidget {
  const _AboutHero();

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [AppColors.primary, Color(0xFF22C55E), Color(0xFF0F766E)],
        ),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        children: [
          Container(
            width: 68,
            height: 68,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.16),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Image.asset(AppImages.imagesAppIcon),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.appName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.brandTagline,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(.88),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
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
          Row(
            children: [
              Icon(icon, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _ValueRow extends StatelessWidget {
  const _ValueRow({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.check_circle_rounded, color: AppColors.primary),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _ContactButton extends StatelessWidget {
  const _ContactButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 46),
        alignment: Alignment.centerRight,
        foregroundColor: AppColors.primary,
        side: BorderSide(color: AppColors.primary.withOpacity(.35)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
