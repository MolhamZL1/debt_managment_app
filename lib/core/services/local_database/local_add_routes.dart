import 'package:debt_managment_app/core/utils/backend_endpoints.dart';

import 'local_client_queries.dart';
import 'local_debt_queries.dart';
import 'local_endpoint_handler.dart';
import 'local_endpoint_result.dart';
import 'local_payment_queries.dart';
import 'local_response_mapper.dart';

class LocalAddRoutes {
  const LocalAddRoutes({
    required LocalClientQueries clients,
    required LocalDebtQueries debts,
    required LocalPaymentQueries payments,
  }) : _clients = clients,
       _debts = debts,
       _payments = payments;

  final LocalClientQueries _clients;
  final LocalDebtQueries _debts;
  final LocalPaymentQueries _payments;

  Map<String, LocalAddHandler> get handlers {
    return {
      BackendEndPoint.addClient:
          (data, _) => LocalEndpointResult.success(_clients.add(data)),
      BackendEndPoint.addDebt:
          (data, _) => LocalEndpointResult.success(_debts.add(data)),
      BackendEndPoint.addPayment:
          (data, _) => LocalEndpointResult.success(_payments.add(data)),
      for (final endpoint in _localAuthEndpoints)
        endpoint: (_, _) async => LocalResponseMapper.localAuthResult(),
    };
  }

  static const _localAuthEndpoints = {
    BackendEndPoint.signOut,
    BackendEndPoint.signIn,
    BackendEndPoint.signUp,
    BackendEndPoint.refresh,
    BackendEndPoint.activeCode,
    BackendEndPoint.resendCode,
    BackendEndPoint.forgotPassword,
    BackendEndPoint.verifyforgetpasswordCode,
    BackendEndPoint.resetPassword,
  };
}
