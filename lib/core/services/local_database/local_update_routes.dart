import 'package:debt_managment_app/core/utils/backend_endpoints.dart';

import 'local_database_helpers.dart';
import 'local_debt_queries.dart';
import 'local_endpoint_handler.dart';
import 'local_endpoint_result.dart';
import 'local_payment_queries.dart';

class LocalUpdateRoutes {
  const LocalUpdateRoutes({
    required LocalDebtQueries debts,
    required LocalPaymentQueries payments,
  }) : _debts = debts,
       _payments = payments;

  final LocalDebtQueries _debts;
  final LocalPaymentQueries _payments;

  Map<String, LocalUpdateHandler> get handlers {
    return {
      BackendEndPoint.updateDebt: (rowid, data) {
        return LocalEndpointResult.success(
          _debts.update(LocalDatabaseHelpers.requiredId(rowid), data),
        );
      },
      BackendEndPoint.updatePayment: (rowid, data) {
        return LocalEndpointResult.success(
          _payments.update(LocalDatabaseHelpers.requiredId(rowid), data),
        );
      },
    };
  }
}
