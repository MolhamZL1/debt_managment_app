import 'package:debt_managment_app/core/routing/routing.dart';
import 'package:debt_managment_app/core/services/get_it_service.dart';
import 'package:debt_managment_app/core/theme/App_themes.dart';
import 'package:debt_managment_app/features/main/presntation/views/main_view.dart';
import 'package:debt_managment_app/features/settings/presentation/cubits/theme/theme_cubit.dart';
import 'package:debt_managment_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/localization/l10n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupSingltonGetIt();

  runApp(DebtManagmentApp());
}

class DebtManagmentApp extends StatelessWidget {
  const DebtManagmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state,
            onGenerateRoute: onGenerateRoute,
            initialRoute: MainView.routename,
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
        },
      ),
    );
  }
}
