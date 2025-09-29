import 'package:debt_managment_app/core/routing/routing.dart';
import 'package:debt_managment_app/core/services/get_it_service.dart';
import 'package:debt_managment_app/features/auth/presentation/views/sign_in_view.dart';
import 'package:debt_managment_app/features/main/presntation/views/main_view.dart';
import 'package:debt_managment_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/localization/l10n.dart';

import 'core/theme/App_themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupSingltonGetIt();
  runApp(const DebtManagmentApp());
}

class DebtManagmentApp extends StatelessWidget {
  const DebtManagmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      onGenerateRoute: onGenerateRoute,
      initialRoute: SignInView.routename,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: Locale("ar"),
    );
  }
}
