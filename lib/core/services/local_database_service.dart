import 'database_service.dart';
import 'local_database/local_client_queries.dart';
import 'local_database/local_database_provider.dart';
import 'local_database/local_debt_queries.dart';
import 'local_database/local_endpoint_router.dart';
import 'local_database/local_home_queries.dart';
import 'local_database/local_payment_queries.dart';
import 'local_database/local_transaction_queries.dart';

class LocalDatabaseService implements DatabaseService {
  LocalDatabaseService({LocalDatabaseProvider? provider})
    : _provider = provider ?? LocalDatabaseProvider() {
    _router = LocalEndpointRouter(
      clients: LocalClientQueries(() => _provider.database),
      debts: LocalDebtQueries(() => _provider.database),
      payments: LocalPaymentQueries(() => _provider.database),
      transactions: LocalTransactionQueries(() => _provider.database),
      home: LocalHomeQueries(() => _provider.database),
    );
  }

  final LocalDatabaseProvider _provider;
  late final LocalEndpointRouter _router;

  @override
  Future addData({
    required String endpoint,
    required Map<String, dynamic>? data,
    String? rowid,
  }) {
    return _router.add(endpoint: endpoint, data: data, rowid: rowid);
  }

  @override
  Future<dynamic> getData({
    required String endpoint,
    String? rowid,
    Map<String, dynamic>? quary,
  }) {
    return _router.get(endpoint: endpoint, rowid: rowid, query: quary);
  }

  @override
  Future<dynamic> deleteData({required String endpoint, String? rowid}) {
    return _router.delete(endpoint: endpoint, rowid: rowid);
  }

  @override
  Future<dynamic> updateData({
    required String endpoint,
    String? rowid,
    dynamic data,
  }) {
    return _router.update(endpoint: endpoint, rowid: rowid, data: data);
  }
}
