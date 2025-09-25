import 'package:get_it/get_it.dart';

import 'api_service.dart';
import 'database_service.dart';

final getIt = GetIt.instance;

setupSingltonGetIt() async {
  getIt.registerSingleton<DatabaseService>(ApiService());
}
