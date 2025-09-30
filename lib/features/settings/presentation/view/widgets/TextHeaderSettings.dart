import 'package:flutter/material.dart';

class TextHeaderSettings extends StatelessWidget {
  final String title;
  const TextHeaderSettings(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 6, end: 6, bottom: 8),
      child: Text(title, style: TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}
