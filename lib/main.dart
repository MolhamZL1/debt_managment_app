import 'package:debt_managment_app/core/routing/routing.dart';
import 'package:debt_managment_app/core/services/get_it_service.dart';
import 'package:debt_managment_app/core/theme/App_themes.dart';
import 'package:debt_managment_app/features/settings/presentation/cubits/currency/currency_cubit.dart';
import 'package:debt_managment_app/features/settings/presentation/cubits/language/language_cubit.dart';
import 'package:debt_managment_app/features/settings/presentation/cubits/theme/theme_cubit.dart';
import 'package:debt_managment_app/features/splash/splash_view.dart';
import 'package:debt_managment_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/localization/l10n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setupSingltonGetIt();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => LanguageCubit()),
        BlocProvider(create: (context) => CurrencyCubit()),
      ],
      child: DebtManagmentApp(),
    ),
  );
}

class DebtManagmentApp extends StatelessWidget {
  const DebtManagmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => S.of(context).appName,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: context.watch<ThemeCubit>().state,
      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashView.routename,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: context.watch<LanguageCubit>().state,
    );
  }
}
