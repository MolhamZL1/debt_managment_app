import 'package:flutter/material.dart';

class BottomSheetListTile extends StatelessWidget {
  const BottomSheetListTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.leadingIcon,
    required this.color,
    required this.onTap,
  });
  final String title;
  final String? subtitle;
  final IconData leadingIcon;
  final Color color;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        onTap: onTap,
        tileColor: color.withOpacity(.08),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        subtitle:
            subtitle == null
                ? null
                : Text(subtitle!, style: const TextStyle(fontSize: 12)),
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: color.withOpacity(.2),
          child: Icon(leadingIcon, size: 20, color: color),
        ),
      ),
    );
  }
}
