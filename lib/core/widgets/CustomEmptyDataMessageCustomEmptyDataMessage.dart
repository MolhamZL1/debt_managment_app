import 'package:flutter/material.dart';

class CustomEmptyDataMessage extends StatelessWidget {
  const CustomEmptyDataMessage({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}
