import 'package:sqflite/sqflite.dart';

import 'local_database_helpers.dart';
import 'local_database_tables.dart';

class LocalClientQueries {
  const LocalClientQueries(this._database);

  final Future<Database> Function() _database;

  Future<int> add(Map<String, dynamic>? data) async {
    final db = await _database();
    final now = LocalDatabaseHelpers.now();

    return db.insert(LocalDatabaseTables.clients, {
      'name': data?['name'],
      'phone': data?['phone'],
      'address': data?['address'],
      'created_at': now,
      'updated_at': now,
    });
  }

  Future<int> delete(int id) async {
    final db = await _database();
    return db.delete(
      LocalDatabaseTables.clients,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> list(
    String category,
    Map<String, dynamic>? query,
  ) async {
    final db = await _database();
    final rows = await db.rawQuery('''
      $_clientsWithBalanceSql
      GROUP BY c.id
      ORDER BY last_transaction_date DESC, c.id DESC
      ''');
    final filtered = rows.where((row) => _matchesCategory(row, category));

    return filtered
        .skip(LocalDatabaseHelpers.offsetFrom(query))
        .take(LocalDatabaseHelpers.pageSize)
        .toList();
  }

  Future<Map<String, dynamic>> get(int id) async {
    final db = await _database();
    final rows = await db.rawQuery(
      '''
      $_clientsWithBalanceSql
      WHERE c.id = ?
      GROUP BY c.id
      LIMIT 1
      ''',
      [id],
    );

    if (rows.isEmpty) {
      throw StateError('العميل غير موجود');
    }

    return rows.first;
  }

  Future<List<Map<String, dynamic>>> search(String value) async {
    final query = value.trim();
    if (query.isEmpty) {
      return const [];
    }

    final db = await _database();
    return db.query(
      LocalDatabaseTables.clients,
      columns: ['id', 'name'],
      where: 'name LIKE ? OR phone LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'name ASC',
      limit: LocalDatabaseHelpers.pageSize,
    );
  }

  bool _matchesCategory(Map<String, dynamic> row, String category) {
    final remaining = (row['remaining'] as num?)?.toDouble() ?? 0;

    return switch (category) {
      'debt' || 'late' => remaining > 0,
      'clear' => remaining <= 0,
      _ => true,
    };
  }

  static const _clientsWithBalanceSql = '''
      SELECT
        c.id,
        c.name,
        c.phone,
        c.address,
        COALESCE(d.total_debts, 0) - COALESCE(p.total_payments, 0) AS remaining,
        NULLIF(MAX(COALESCE(d.last_debt_date, ''), COALESCE(p.last_payment_date, '')), '')
          AS last_transaction_date
      FROM clients c
      LEFT JOIN (
        SELECT client_id, SUM(amount) AS total_debts, MAX(debt_date) AS last_debt_date
        FROM debts
        GROUP BY client_id
      ) d ON d.client_id = c.id
      LEFT JOIN (
        SELECT client_id, SUM(amount) AS total_payments, MAX(payment_date) AS last_payment_date
        FROM payments
        GROUP BY client_id
      ) p ON p.client_id = c.id
    ''';
}
