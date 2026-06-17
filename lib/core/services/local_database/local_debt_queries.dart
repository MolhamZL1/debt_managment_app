import 'package:sqflite/sqflite.dart';

import 'local_database_helpers.dart';
import 'local_database_tables.dart';
import 'local_response_mapper.dart';

class LocalDebtQueries {
  const LocalDebtQueries(this._database);

  final Future<Database> Function() _database;

  Future<int> add(Map<String, dynamic>? data) async {
    final db = await _database();
    final now = LocalDatabaseHelpers.now();

    return db.insert(LocalDatabaseTables.debts, {
      'client_id': data?['client_id'],
      'amount': data?['amount'],
      'description': data?['description'],
      'debt_date': now,
      'created_at': now,
      'updated_at': now,
    });
  }

  Future<int> delete(int id) async {
    final db = await _database();
    return db.delete(
      LocalDatabaseTables.debts,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(int id, dynamic data) async {
    final db = await _database();
    return db.update(
      LocalDatabaseTables.debts,
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
      LocalDatabaseTables.debts,
      where: 'client_id = ?',
      whereArgs: [clientId],
      orderBy: 'debt_date DESC, id DESC',
      limit: LocalDatabaseHelpers.pageSize,
      offset: LocalDatabaseHelpers.offsetFrom(query),
    );

    return rows.map(LocalResponseMapper.debt).toList();
  }
}
