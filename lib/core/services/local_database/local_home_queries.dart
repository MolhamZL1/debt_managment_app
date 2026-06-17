import 'package:sqflite/sqflite.dart';

import 'local_response_mapper.dart';

class LocalHomeQueries {
  const LocalHomeQueries(this._database);

  final Future<Database> Function() _database;

  Future<Map<String, dynamic>> get() async {
    final db = await _database();
    final balances = await db.rawQuery(_balanceSql);
    final recentDebts = await db.rawQuery(_recentDebtsSql);
    final recentPayments = await db.rawQuery(_recentPaymentsSql);
    final summary = balances.first;

    return {
      'balance': summary['balance'] ?? 0,
      'clients_count': summary['clients_count'] ?? 0,
      'clients_in_debt': summary['clients_in_debt'] ?? 0,
      'clients_clear': summary['clients_clear'] ?? 0,
      'recent_debts': recentDebts.map(LocalResponseMapper.transaction).toList(),
      'recent_payments':
          recentPayments.map(LocalResponseMapper.transaction).toList(),
    };
  }

  static const _balanceSql = '''
      SELECT
        COUNT(*) AS clients_count,
        SUM(CASE WHEN remaining > 0 THEN 1 ELSE 0 END) AS clients_in_debt,
        SUM(CASE WHEN remaining <= 0 THEN 1 ELSE 0 END) AS clients_clear,
        COALESCE(SUM(CASE WHEN remaining > 0 THEN remaining ELSE 0 END), 0)
          AS balance
      FROM (
        SELECT
          c.id,
          COALESCE(d.total_debts, 0) - COALESCE(p.total_payments, 0) AS remaining
        FROM clients c
        LEFT JOIN (
          SELECT client_id, SUM(amount) AS total_debts
          FROM debts
          GROUP BY client_id
        ) d ON d.client_id = c.id
        LEFT JOIN (
          SELECT client_id, SUM(amount) AS total_payments
          FROM payments
          GROUP BY client_id
        ) p ON p.client_id = c.id
      )
    ''';

  static const _recentDebtsSql = '''
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
      ORDER BY d.debt_date DESC, d.id DESC
      LIMIT 5
    ''';

  static const _recentPaymentsSql = '''
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
      ORDER BY p.payment_date DESC, p.id DESC
      LIMIT 5
    ''';
}
