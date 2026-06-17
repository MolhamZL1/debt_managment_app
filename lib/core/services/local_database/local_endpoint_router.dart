import 'local_add_routes.dart';
import 'local_client_queries.dart';
import 'local_delete_routes.dart';
import 'local_debt_queries.dart';
import 'local_endpoint_handler.dart';
import 'local_endpoint_result.dart';
import 'local_get_routes.dart';
import 'local_home_queries.dart';
import 'local_payment_queries.dart';
import 'local_transaction_queries.dart';
import 'local_update_routes.dart';

class LocalEndpointRouter {
  LocalEndpointRouter({
    required LocalClientQueries clients,
    required LocalDebtQueries debts,
    required LocalPaymentQueries payments,
    required LocalTransactionQueries transactions,
    required LocalHomeQueries home,
  }) : _addHandlers =
           LocalAddRoutes(
             clients: clients,
             debts: debts,
             payments: payments,
           ).handlers,
       _getHandlers =
           LocalGetRoutes(
             clients: clients,
             debts: debts,
             payments: payments,
             transactions: transactions,
             home: home,
           ).handlers,
       _deleteHandlers =
           LocalDeleteRoutes(
             clients: clients,
             debts: debts,
             payments: payments,
           ).handlers,
       _updateHandlers =
           LocalUpdateRoutes(debts: debts, payments: payments).handlers;

  final Map<String, LocalAddHandler> _addHandlers;
  final Map<String, LocalGetHandler> _getHandlers;
  final Map<String, LocalDeleteHandler> _deleteHandlers;
  final Map<String, LocalUpdateHandler> _updateHandlers;

  Future<dynamic> add({
    required String endpoint,
    required Map<String, dynamic>? data,
    String? rowid,
  }) async {
    final handler = _addHandlers[endpoint] ?? _unsupportedAdd(endpoint);
    return handler(data, rowid);
  }

  Future<dynamic> get({
    required String endpoint,
    String? rowid,
    Map<String, dynamic>? query,
  }) async {
    final handler = _getHandlers[endpoint] ?? _unsupportedGet(endpoint);
    return handler(rowid, query);
  }

  Future<dynamic> delete({required String endpoint, String? rowid}) async {
    final handler = _deleteHandlers[endpoint] ?? _unsupportedDelete(endpoint);
    return handler(rowid);
  }

  Future<dynamic> update({
    required String endpoint,
    String? rowid,
    dynamic data,
  }) async {
    final handler = _updateHandlers[endpoint] ?? _unsupportedUpdate(endpoint);
    return handler(rowid, data);
  }

  LocalAddHandler _unsupportedAdd(String endpoint) {
    return (_, _) => throw LocalEndpointResult.unsupported(endpoint);
  }

  LocalGetHandler _unsupportedGet(String endpoint) {
    return (_, _) => throw LocalEndpointResult.unsupported(endpoint);
  }

  LocalDeleteHandler _unsupportedDelete(String endpoint) {
    return (_) => throw LocalEndpointResult.unsupported(endpoint);
  }

  LocalUpdateHandler _unsupportedUpdate(String endpoint) {
    return (_, _) => throw LocalEndpointResult.unsupported(endpoint);
  }
}
