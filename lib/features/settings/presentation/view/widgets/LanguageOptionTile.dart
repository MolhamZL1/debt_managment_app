import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/language/language_cubit.dart';

class LanguageOptionTile extends StatelessWidget {
  const LanguageOptionTile({required this.language, required this.title});

  final AppLanguage language;
  final String title;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<LanguageCubit>();
    final isSelected = cubit.currentLanguage == language;

    return RadioListTile<AppLanguage>(
      value: language,
      groupValue: cubit.currentLanguage,
      title: Text(title),
      secondary: Icon(
        language == AppLanguage.system
            ? Icons.phone_iphone_rounded
            : Icons.translate_rounded,
      ),
      selected: isSelected,
      onChanged: (value) {
        if (value == null) return;
        context.read<LanguageCubit>().setLanguage(value);
        Navigator.pop(context);
      },
    );
  }
}
