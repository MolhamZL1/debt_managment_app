import 'package:sqflite/sqflite.dart';

import 'local_database_helpers.dart';
import 'local_response_mapper.dart';

class LocalTransactionQueries {
  const LocalTransactionQueries(this._database);

  final Future<Database> Function() _database;

  Future<List<Map<String, dynamic>>> byClient(
    int clientId,
    Map<String, dynamic>? query,
  ) async {
    final db = await _database();
    final rows = await db.rawQuery(
      '''
      SELECT
        id,
        client_id,
        amount,
        description,
        debt_date AS date,
        'debt' AS type
      FROM debts
      WHERE client_id = ?
      UNION ALL
      SELECT
        id,
        client_id,
        amount,
        notes AS description,
        payment_date AS date,
        'payment' AS type
      FROM payments
      WHERE client_id = ?
      ORDER BY date DESC, id DESC
      LIMIT ? OFFSET ?
      ''',
      [
        clientId,
        clientId,
        LocalDatabaseHelpers.pageSize,
        LocalDatabaseHelpers.offsetFrom(query),
      ],
    );

    return rows.map(LocalResponseMapper.clientTransaction).toList();
  }

  Future<List<Map<String, dynamic>>> list(
    String category,
    Map<String, dynamic>? query,
  ) async {
    final db = await _database();
    final rows = await db.rawQuery(
      '''
      SELECT * FROM ($_transactionsSql)
      ${_typeFilter(category)}
      ORDER BY date DESC, id DESC
      LIMIT ? OFFSET ?
      ''',
      [LocalDatabaseHelpers.pageSize, LocalDatabaseHelpers.offsetFrom(query)],
    );

    return rows.map(LocalResponseMapper.transaction).toList();
  }

  String _typeFilter(String category) {
    return switch (category) {
      'debt' => "WHERE type = 'debt'",
      'payment' => "WHERE type = 'payment'",
      _ => '',
    };
  }

  static const _transactionsSql = '''
        SELECT
          d.id,
          d.client_id,
          c.name AS client_name,
          d.amount,
          d.description,
          d.debt_date AS date,
          'debt' AS type
        FROM debts d
        INNER JOIN clients c ON c.id = d.client_id
        UNION ALL
        SELECT
          p.id,
          p.client_id,
          c.name AS client_name,
          p.amount,
          p.notes AS description,
          p.payment_date AS date,
          'payment' AS type
        FROM payments p
        INNER JOIN clients c ON c.id = p.client_id
    ''';
}
