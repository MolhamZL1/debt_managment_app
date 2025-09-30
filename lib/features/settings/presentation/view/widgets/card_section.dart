import 'package:flutter/material.dart';

class CardSection extends StatelessWidget {
  final List<Widget> children;
  const CardSection({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(children: children),
    );
  }
}
