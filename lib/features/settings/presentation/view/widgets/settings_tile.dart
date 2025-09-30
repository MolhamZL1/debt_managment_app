import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? leadingIcon;
  final Widget? trailingWidget;

  const SettingsTile({
    super.key,
    required this.title,
    this.leadingIcon,
    this.subtitle,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      subtitle:
          subtitle == null
              ? null
              : Text(subtitle!, style: const TextStyle(fontSize: 12)),
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: AppColors.primary.withOpacity(.15),
        child: Icon(leadingIcon, size: 20, color: AppColors.primary),
      ),
      trailing: trailingWidget,
    );
  }
}
