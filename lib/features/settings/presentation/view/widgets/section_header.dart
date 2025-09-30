import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 6, end: 6, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey.shade800,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
