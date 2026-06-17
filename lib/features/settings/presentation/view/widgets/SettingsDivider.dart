import 'package:flutter/material.dart';

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      indent: 72,
      endIndent: 14,
      color:
          Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withOpacity(.07)
              : Colors.black.withOpacity(.06),
    );
  }
}
