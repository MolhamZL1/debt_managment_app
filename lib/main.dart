import 'package:debt_managment_app/core/routing/routing.dart';
import 'package:debt_managment_app/core/services/get_it_service.dart';
import 'package:debt_managment_app/features/main/presntation/views/main_view.dart';
import 'package:debt_managment_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'core/theme/App_themes.dart'; // يحتوي AppTheme.lightTheme و AppTheme.darkTheme

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupSingltonGetIt();

  runApp(
    ThemeProvider(
      initTheme: AppTheme.lightTheme, // الثيم الابتدائي
      builder: (context, currentTheme) {
        return DebtManagmentApp(theme: currentTheme);
      },
    ),
  );
}

class DebtManagmentApp extends StatelessWidget {
  final ThemeData theme;
  const DebtManagmentApp({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // ✅ ناخد الثيم من animated_theme_switcher
      theme: theme,

      // ما منحتاج darkTheme/themeMode لأننا عم نبدّل الـ ThemeData نفسه
      // darkTheme: AppTheme.darkTheme,
      // themeMode: ThemeMode.light,

      onGenerateRoute: onGenerateRoute,
      initialRoute: MainView.routename,

      // خلي الـ ThemeSwitchingArea متاح لكل الشجرة
      builder: (context, child) => ThemeSwitchingArea(child: child!),

      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale("ar"),
    );
  }
}
