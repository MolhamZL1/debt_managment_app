import 'package:debt_managment_app/core/utils/backend_endpoints.dart';

import 'local_client_queries.dart';
import 'local_database_helpers.dart';
import 'local_debt_queries.dart';
import 'local_endpoint_handler.dart';
import 'local_home_queries.dart';
import 'local_payment_queries.dart';
import 'local_response_mapper.dart';
import 'local_transaction_queries.dart';

class LocalGetRoutes {
  const LocalGetRoutes({
    required LocalClientQueries clients,
    required LocalDebtQueries debts,
    required LocalPaymentQueries payments,
    required LocalTransactionQueries transactions,
    required LocalHomeQueries home,
  }) : _clients = clients,
       _debts = debts,
       _payments = payments,
       _transactions = transactions,
       _home = home;

  final LocalClientQueries _clients;
  final LocalDebtQueries _debts;
  final LocalPaymentQueries _payments;
  final LocalTransactionQueries _transactions;
  final LocalHomeQueries _home;

  Map<String, LocalGetHandler> get handlers {
    return {
      BackendEndPoint.clientes: (rowid, query) async {
        return {'result': await _clients.list(rowid ?? 'all', query)};
      },
      BackendEndPoint.clienteData: (rowid, _) async {
        return {
          'result': await _clients.get(LocalDatabaseHelpers.requiredId(rowid)),
        };
      },
      BackendEndPoint.clientsSearch: (_, query) async {
        return {'result': await _clients.search(query?['q']?.toString() ?? '')};
      },
      BackendEndPoint.debtsClient: (rowid, query) async {
        return {
          'result': {
            'data': await _debts.byClient(
              LocalDatabaseHelpers.requiredId(rowid),
              query,
            ),
          },
        };
      },
      BackendEndPoint.paymentsClinet: (rowid, query) async {
        return {
          'result': {
            'data': await _payments.byClient(
              LocalDatabaseHelpers.requiredId(rowid),
              query,
            ),
          },
        };
      },
      BackendEndPoint.transactionsClient: (rowid, query) async {
        return {
          'result': await _transactions.byClient(
            LocalDatabaseHelpers.requiredId(rowid),
            query,
          ),
        };
      },
      BackendEndPoint.transaction: (rowid, query) async {
        return {'result': await _transactions.list(rowid ?? 'all', query)};
      },
      BackendEndPoint.homeView: (_, _) async => {'result': await _home.get()},
      BackendEndPoint.me: (_, _) async => LocalResponseMapper.localAuthResult(),
    };
  }
}
