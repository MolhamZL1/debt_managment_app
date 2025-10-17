import 'package:flutter/material.dart';

class SettingsCardSection extends StatelessWidget {
  final List<Widget> children;
  const SettingsCardSection({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(children: children),
    );
  }
}
