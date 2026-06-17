import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';
import '../../cubits/language/language_cubit.dart';
import 'LanguageOptionTile.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final languageCubit = context.read<LanguageCubit>();
    return BlocProvider.value(
      value: languageCubit,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.languageDialogTitle,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              LanguageOptionTile(
                language: AppLanguage.ar,
                title: l10n.languageArabic,
              ),
              LanguageOptionTile(
                language: AppLanguage.en,
                title: l10n.languageEnglish,
              ),
              LanguageOptionTile(
                language: AppLanguage.system,
                title: l10n.languageSystem,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
