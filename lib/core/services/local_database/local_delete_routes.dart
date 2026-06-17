import 'package:debt_managment_app/core/utils/backend_endpoints.dart';

import 'local_client_queries.dart';
import 'local_database_helpers.dart';
import 'local_debt_queries.dart';
import 'local_endpoint_handler.dart';
import 'local_endpoint_result.dart';
import 'local_payment_queries.dart';

class LocalDeleteRoutes {
  const LocalDeleteRoutes({
    required LocalClientQueries clients,
    required LocalDebtQueries debts,
    required LocalPaymentQueries payments,
  }) : _clients = clients,
       _debts = debts,
       _payments = payments;

  final LocalClientQueries _clients;
  final LocalDebtQueries _debts;
  final LocalPaymentQueries _payments;

  Map<String, LocalDeleteHandler> get handlers {
    return {
      BackendEndPoint.deleteClient: (rowid) {
        return LocalEndpointResult.success(
          _clients.delete(LocalDatabaseHelpers.requiredId(rowid)),
        );
      },
      BackendEndPoint.deleteDebt: (rowid) {
        return LocalEndpointResult.success(
          _debts.delete(LocalDatabaseHelpers.requiredId(rowid)),
        );
      },
      BackendEndPoint.deletePayment: (rowid) {
        return LocalEndpointResult.success(
          _payments.delete(LocalDatabaseHelpers.requiredId(rowid)),
        );
      },
    };
  }
}
