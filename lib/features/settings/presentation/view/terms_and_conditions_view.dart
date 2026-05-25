import 'package:debt_managment_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});
  static const String routename = '/terms_and_conditions';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const items = [
      (
        'الاستخدام الشخصي',
        'التطبيق مخصص لتسجيل ومتابعة الديون والدفعات بطريقة تنظيمية ولا يعد بديلًا عن الاستشارة القانونية أو المحاسبية.',
      ),
      (
        'دقة البيانات',
        'المستخدم مسؤول عن إدخال البيانات ومراجعتها والتأكد من صحة المبالغ والتواريخ.',
      ),
      (
        'البيانات المحلية',
        'بما أن التطبيق يعمل دون خادم، فإن الحفاظ على الجهاز ونسخ البيانات احتياطيًا مسؤولية المستخدم.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('الشروط والأحكام')),
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
                const CircleAvatar(
                  radius: 27,
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.gavel_rounded, color: Colors.white),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'باستخدام سجّلها، أنت توافق على استخدامه كأداة تنظيم محلية لإدارة سجلاتك.',
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
          for (final item in items)
            Container(
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
                    item.$1,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.$2,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark ? Colors.white70 : AppColors.textGrey,
                      height: 1.55,
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
