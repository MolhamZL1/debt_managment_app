import 'package:sqflite/sqflite.dart';

import 'local_database_helpers.dart';
import 'local_database_tables.dart';
import 'local_response_mapper.dart';

class LocalPaymentQueries {
  const LocalPaymentQueries(this._database);

  final Future<Database> Function() _database;

  Future<int> add(Map<String, dynamic>? data) async {
    final db = await _database();
    final now = LocalDatabaseHelpers.now();

    return db.insert(LocalDatabaseTables.payments, {
      'client_id': data?['client_id'],
      'amount': data?['amount'],
      'notes': data?['notes'],
      'payment_date': now,
      'created_at': now,
      'updated_at': now,
    });
  }

  Future<int> delete(int id) async {
    final db = await _database();
    return db.delete(
      LocalDatabaseTables.payments,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(int id, dynamic data) async {
    final db = await _database();
    return db.update(
      LocalDatabaseTables.payments,
      {'amount': data['amount'], 'updated_at': LocalDatabaseHelpers.now()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> byClient(
    int clientId,
    Map<String, dynamic>? query,
  ) async {
    final db = await _database();
    final rows = await db.query(
      LocalDatabaseTables.payments,
      where: 'client_id = ?',
      whereArgs: [clientId],
      orderBy: 'payment_date DESC, id DESC',
      limit: LocalDatabaseHelpers.pageSize,
      offset: LocalDatabaseHelpers.offsetFrom(query),
    );

    return rows.map(LocalResponseMapper.payment).toList();
  }
}
