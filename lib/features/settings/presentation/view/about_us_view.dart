import 'package:flutter/material.dart';

/// ====== معلومات قابلة للتعديل بسهولة ======
class AppBrand {
  static const String appName = 'سجّلها';
  static const String tagline = 'أسهل طريقة لإدارة الديون والمتابعة الذكية';
  static const String mission =
      'تمكين الأفراد وأصحاب المحال من تسجيل الديون والمدفوعات بسرعة، '
      'ومتابعة الأرصدة بشكل موثوق وبواجهة عربية بسيطة.';
  static const String vision =
      'أن يصبح سجّلها التطبيق العربي المرجعي لإدارة التعاملات المالية اليومية '
      'بدون تعقيد، مع دعم العمل دون إنترنت قريباً.';
  static const List<String> values = [
    'الخصوصية أولاً',
    'البساطة والسرعة',
    'الشفافية في الأرقام',
    'التحسين المستمر بناءً على ملاحظاتكم',
  ];

  static const String email = 'support@sajjilha.app';
  static const String whatsapp = '+963 9XX XXX XXX';
  static const String website = 'https://sajjilha.app';
  static const String version = '1.0.0';

  static const int primaryColorHex = 0xFF16A34A;
}

/// يمكن عرض أعضاء الفريق (اختياري)
class TeamMember {
  final String name;
  final String role;
  final String? avatarUrl; // ضع null إن لم تتوفر صورة

  const TeamMember({required this.name, required this.role, this.avatarUrl});
}

const List<TeamMember> kTeam = [
  TeamMember(name: 'Molham', role: 'Founder & Flutter Dev', avatarUrl: null),
  TeamMember(name: 'Saba', role: 'Product & QA', avatarUrl: null),
];

/// ====== صفحة "من نحن" ======
class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});
  static const String routename = '/about_us';

  Color get primary => const Color(AppBrand.primaryColorHex);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('من نحن'),
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Header(
            title: AppBrand.appName,
            subtitle: AppBrand.tagline,
            color: primary,
          ),

          const SizedBox(height: 16),
          _SectionCard(
            title: 'رسالتنا',
            child: Text(
              AppBrand.mission,
              style: textTheme.bodyMedium?.copyWith(height: 1.6),
            ),
          ),

          const SizedBox(height: 12),
          _SectionCard(
            title: 'رؤيتنا',
            child: Text(
              AppBrand.vision,
              style: textTheme.bodyMedium?.copyWith(height: 1.6),
            ),
          ),

          const SizedBox(height: 12),
          _SectionCard(
            title: 'قيمنا',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final v in AppBrand.values)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: primary, size: 20),
                        const SizedBox(width: 8),
                        Expanded(child: Text(v, style: textTheme.bodyMedium)),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          if (kTeam.isNotEmpty) ...[
            const SizedBox(height: 12),
            _SectionCard(
              title: 'الفريق',
              child: Column(
                children: [
                  for (final m in kTeam) _TeamTile(member: m, color: primary),
                ],
              ),
            ),
          ],

          const SizedBox(height: 12),
          _SectionCard(
            title: 'تواصل معنا',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ContactRow(
                  icon: Icons.email,
                  label: 'البريد الإلكتروني',
                  value: AppBrand.email,
                ),
                const SizedBox(height: 8),
                _ContactRow(
                  icon: Icons.phone,
                  label: 'واتساب',
                  value: AppBrand.whatsapp,
                ),
                const SizedBox(height: 8),
                _ContactRow(
                  icon: Icons.language,
                  label: 'الموقع',
                  value: AppBrand.website,
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
          Center(
            child: Text(
              'الإصدار: ${AppBrand.version}',
              style: textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

/// ====== Widgets داخلية صغيرة لصفحة من نحن ======

class _Header extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  const _Header({
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.menu_book_rounded, color: color, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(height: 1.4),
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
  final String title;
  final Widget child;
  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700);

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: titleStyle),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

class _TeamTile extends StatelessWidget {
  final TeamMember member;
  final Color color;
  const _TeamTile({required this.member, required this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.12),
        foregroundColor: color,
        radius: 22,
        backgroundImage:
            (member.avatarUrl != null) ? NetworkImage(member.avatarUrl!) : null,
        child: (member.avatarUrl == null) ? const Icon(Icons.person) : null,
      ),
      title: Text(
        member.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(member.role),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final primary = const Color(AppBrand.primaryColorHex);
    return Row(
      children: [
        Icon(icon, color: primary, size: 20),
        const SizedBox(width: 8),
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
        Expanded(
          child: SelectableText(value, style: const TextStyle(height: 1.4)),
        ),
      ],
    );
  }
}
