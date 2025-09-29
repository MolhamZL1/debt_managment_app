import 'package:debt_managment_app/features/auth/data/repo/auth_repo_imp.dart';
import 'package:debt_managment_app/features/auth/domain/repo/auth_repo.dart';
import 'package:get_it/get_it.dart';

import 'api_service.dart';
import 'database_service.dart';

final getIt = GetIt.instance;

setupSingltonGetIt() async {
  getIt.registerSingleton<DatabaseService>(ApiService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImp(databaseService: getIt.get<DatabaseService>()),
  );
}
