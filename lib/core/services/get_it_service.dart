import 'package:debt_managment_app/features/auth/data/repo/auth_repo_imp.dart';
import 'package:debt_managment_app/features/auth/domain/repo/auth_repo.dart';
import 'package:debt_managment_app/features/clientes/data/repo/client_repo_imp.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/clientes_repo.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/transaction_client_repo.dart';
import 'package:debt_managment_app/features/home/data/repo/home_view_repo_imp.dart';
import 'package:debt_managment_app/features/home/domain/repo/home_view_repo.dart';
import 'package:debt_managment_app/features/transactions/data/repo/transaction_repo_imp.dart';
import 'package:get_it/get_it.dart';

import '../../features/clientes/data/repo/debt_client_repo_imp.dart';
import '../../features/clientes/data/repo/payment_client_repo_imp.dart';
import '../../features/clientes/data/repo/transaction_client_repo_imp.dart';
import '../../features/clientes/domain/repo/debt_client_repo.dart';
import '../../features/clientes/domain/repo/payment_client_repo.dart';
import '../../features/main/data/repo/ClientSearchDropDownRepoImp.dart';
import '../../features/main/domain/repo/ClientSearchDropDown_repo.dart';
import '../../features/transactions/domain/repo/transaction_repo.dart';
import 'api_service.dart';
import 'database_service.dart';

final getIt = GetIt.instance;

setupSingltonGetIt() async {
  getIt.registerSingleton<DatabaseService>(ApiService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImp(databaseService: getIt.get<DatabaseService>()),
  );
  getIt.registerSingleton<ClientesRepo>(
    ClientRepoImp(databaseService: getIt.get<DatabaseService>()),
  );
  getIt.registerSingleton<DebtClientRepo>(
    DebtClientRepoImp(databaseService: getIt.get<DatabaseService>()),
  );
  getIt.registerSingleton<PaymentClientRepo>(
    PaymentClientRepoImp(databaseService: getIt.get<DatabaseService>()),
  );
  getIt.registerSingleton<TransactionClientRepo>(
    TransactionClientRepoImp(databaseService: getIt.get<DatabaseService>()),
  );
  getIt.registerSingleton<TransactionRepo>(
    TransactionRepoImp(databaseService: getIt.get<DatabaseService>()),
  );
  getIt.registerSingleton<ClientSearchDropDownRepo>(
    ClientSearchDropdownRepoImpl(databaseService: getIt.get<DatabaseService>()),
  );
  getIt.registerSingleton<HomeViewRepo>(
    HomeViewRepoImp(databaseService: getIt.get<DatabaseService>()),
  );
}
