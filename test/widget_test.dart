import 'package:debt_managment_app/core/services/database_service.dart';
import 'package:debt_managment_app/core/services/get_it_service.dart';
import 'package:debt_managment_app/features/settings/presentation/cubits/language/language_cubit.dart';
import 'package:debt_managment_app/features/settings/presentation/cubits/theme/theme_cubit.dart';
import 'package:debt_managment_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('App builds smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    if (!getIt.isRegistered<DatabaseService>()) {
      setupSingltonGetIt();
    }

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeCubit()),
          BlocProvider(create: (context) => LanguageCubit()),
        ],
        child: const DebtManagmentApp(),
      ),
    );

    expect(find.byType(DebtManagmentApp), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1300));
    await tester.pump();
    expect(find.text('تابع الديون بوضوح'), findsOneWidget);
  });
}
