import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData ?trailingIcon;
  final Widget? trailingWidget; //
  final Widget? leading; // نص يسار مثل اسم المستخدم

  const SettingsTile({
    super.key,
    required this.title,
     this.trailingIcon,
    this.subtitle,
    this.leading, this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Row(
        children: [
          if (trailingWidget != null)
            trailingWidget!
          else if (trailingIcon != null)
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.background,
            child: Icon(trailingIcon, size: 18, color: AppColors.primary),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          if (leading != null) ...[
            leading!,
            const Spacer(),
          ] else
            const SizedBox.shrink(),
        ],
      ),
    );
  }
}
