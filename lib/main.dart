import 'package:debt_managment_app/core/routing/routing.dart';
import 'package:debt_managment_app/features/auth/presentation/views/sign_in_view.dart';
import 'package:debt_managment_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'features/auth/presentation/views/sign_up_view.dart';

void main() {
  runApp(const DebtManagmentApp());
}

class DebtManagmentApp extends StatelessWidget {
  const DebtManagmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      initialRoute: SignInView.routename,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: Locale("ar"),
      home: SignInView(),
    );
  }
}
