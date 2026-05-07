import 'package:debt_managment_app/core/utils/backend_endpoints.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_service.dart';

class LocalDatabaseService implements DatabaseService {
  static const int _pageSize = 10;

  Database? _database;

  Future<Database> get _db async {
    if (_database != null) {
      return _database!;
    }

    final path = join(await getDatabasesPath(), 'sajilha_local.db');
    _database = await openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE clients (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            phone TEXT,
            address TEXT,
            created_at TEXT NOT NULL,
            updated_at TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE debts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            client_id INTEGER NOT NULL,
            amount REAL NOT NULL,
            description TEXT,
            debt_date TEXT NOT NULL,
            created_at TEXT NOT NULL,
            updated_at TEXT NOT NULL,
            FOREIGN KEY (client_id) REFERENCES clients (id) ON DELETE CASCADE
          )
        ''');

        await db.execute('''
          CREATE TABLE payments (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            client_id INTEGER NOT NULL,
            amount REAL NOT NULL,
            notes TEXT,
            payment_date TEXT NOT NULL,
            created_at TEXT NOT NULL,
            updated_at TEXT NOT NULL,
            FOREIGN KEY (client_id) REFERENCES clients (id) ON DELETE CASCADE
          )
        ''');
      },
    );

    return _database!;
  }

  @override
  Future addData({
    required String endpoint,
    required Map<String, dynamic>? data,
    String? rowid,
  }) async {
    final db = await _db;
    final now = _now();

    switch (endpoint) {
      case BackendEndPoint.addClient:
        await db.insert('clients', {
          'name': data?['name'],
          'phone': data?['phone'],
          'address': data?['address'],
          'created_at': now,
          'updated_at': now,
        });
        return {'result': true};

      case BackendEndPoint.addDebt:
        await db.insert('debts', {
          'client_id': data?['client_id'],
          'amount': data?['amount'],
          'description': data?['description'],
          'debt_date': now,
          'created_at': now,
          'updated_at': now,
        });
        return {'result': true};

      case BackendEndPoint.addPayment:
        await db.insert('payments', {
          'client_id': data?['client_id'],
          'amount': data?['amount'],
          'notes': data?['notes'],
          'payment_date': now,
          'created_at': now,
          'updated_at': now,
        });
        return {'result': true};

      case BackendEndPoint.signOut:
      case BackendEndPoint.signIn:
      case BackendEndPoint.signUp:
      case BackendEndPoint.refresh:
      case BackendEndPoint.activeCode:
      case BackendEndPoint.resendCode:
      case BackendEndPoint.forgotPassword:
      case BackendEndPoint.verifyforgetpasswordCode:
      case BackendEndPoint.resetPassword:
        return _localAuthResult();

      default:
        throw UnsupportedError('Local endpoint is not supported: $endpoint');
    }
  }

  @override
  Future<dynamic> getData({
    required String endpoint,
    String? rowid,
    Map<String, dynamic>? quary,
  }) async {
    switch (endpoint) {
      case BackendEndPoint.clientes:
        return {'result': await _getClients(rowid ?? 'all', quary)};
      case BackendEndPoint.clienteData:
        return {'result': await _getClient(int.parse(rowid!))};
      case BackendEndPoint.clientsSearch:
        return {'result': await _searchClients(quary?['q']?.toString() ?? '')};
      case BackendEndPoint.debtsClient:
        return {
          'result': {'data': await _getClientDebts(int.parse(rowid!), quary)},
        };
      case BackendEndPoint.paymentsClinet:
        return {
          'result': {
            'data': await _getClientPayments(int.parse(rowid!), quary),
          },
        };
      case BackendEndPoint.transactionsClient:
        return {
          'result': await _getClientTransactions(int.parse(rowid!), quary),
        };
      case BackendEndPoint.transaction:
        return {'result': await _getTransactions(rowid ?? 'all', quary)};
      case BackendEndPoint.homeView:
        return {'result': await _getHomeView()};
      case BackendEndPoint.me:
        return _localAuthResult();
      default:
        throw UnsupportedError('Local endpoint is not supported: $endpoint');
    }
  }

  @override
  Future<dynamic> deleteData({required String endpoint, String? rowid}) async {
    final db = await _db;
    final id = int.parse(rowid!);

    switch (endpoint) {
      case BackendEndPoint.deleteClient:
        await db.delete('clients', where: 'id = ?', whereArgs: [id]);
        return {'result': true};
      case BackendEndPoint.deleteDebt:
        await db.delete('debts', where: 'id = ?', whereArgs: [id]);
        return {'result': true};
      case BackendEndPoint.deletePayment:
        await db.delete('payments', where: 'id = ?', whereArgs: [id]);
        return {'result': true};
      default:
        throw UnsupportedError('Local endpoint is not supported: $endpoint');
    }
  }

  @override
  Future<dynamic> updateData({
    required String endpoint,
    String? rowid,
    dynamic data,
  }) async {
    final db = await _db;
    final id = int.parse(rowid!);
    final now = _now();

    switch (endpoint) {
      case BackendEndPoint.updateDebt:
        await db.update(
          'debts',
          {'amount': data['amount'], 'updated_at': now},
          where: 'id = ?',
          whereArgs: [id],
        );
        return {'result': true};
      case BackendEndPoint.updatePayment:
        await db.update(
          'payments',
          {'amount': data['amount'], 'updated_at': now},
          where: 'id = ?',
          whereArgs: [id],
        );
        return {'result': true};
      default:
        throw UnsupportedError('Local endpoint is not supported: $endpoint');
    }
  }

  Future<List<Map<String, dynamic>>> _getClients(
    String category,
    Map<String, dynamic>? query,
  ) async {
    final db = await _db;
    final page = _pageFrom(query);
    final rows = await db.rawQuery('''
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
      GROUP BY c.id
      ORDER BY last_transaction_date DESC, c.id DESC
      ''');

    final filtered =
        rows.where((row) => _matchesClientCategory(row, category)).toList();
    final offset = (page - 1) * _pageSize;
    return filtered.skip(offset).take(_pageSize).toList();
  }

  Future<Map<String, dynamic>> _getClient(int id) async {
    final db = await _db;
    final rows = await db.rawQuery(
      '''
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

  Future<List<Map<String, dynamic>>> _searchClients(String query) async {
    if (query.trim().isEmpty) {
      return const [];
    }

    final db = await _db;
    return db.query(
      'clients',
      columns: ['id', 'name'],
      where: 'name LIKE ? OR phone LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'name ASC',
      limit: 10,
    );
  }

  Future<List<Map<String, dynamic>>> _getClientDebts(
    int clientId,
    Map<String, dynamic>? query,
  ) async {
    final db = await _db;
    final page = _pageFrom(query);
    final rows = await db.query(
      'debts',
      where: 'client_id = ?',
      whereArgs: [clientId],
      orderBy: 'debt_date DESC, id DESC',
      limit: _pageSize,
      offset: (page - 1) * _pageSize,
    );

    return rows.map(_debtApiMap).toList();
  }

  Future<List<Map<String, dynamic>>> _getClientPayments(
    int clientId,
    Map<String, dynamic>? query,
  ) async {
    final db = await _db;
    final page = _pageFrom(query);
    final rows = await db.query(
      'payments',
      where: 'client_id = ?',
      whereArgs: [clientId],
      orderBy: 'payment_date DESC, id DESC',
      limit: _pageSize,
      offset: (page - 1) * _pageSize,
    );

    return rows.map(_paymentApiMap).toList();
  }

  Future<List<Map<String, dynamic>>> _getClientTransactions(
    int clientId,
    Map<String, dynamic>? query,
  ) async {
    final db = await _db;
    final page = _pageFrom(query);
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
      [clientId, clientId, _pageSize, (page - 1) * _pageSize],
    );

    return rows.map((row) {
      if (row['type'] == 'debt') {
        return {
          'id': row['id'],
          'client_id': row['client_id'],
          'amount': row['amount'].toString(),
          'description': row['description'],
          'debt_date': row['date'],
          'type': 'debt',
        };
      }

      return {
        'id': row['id'],
        'client_id': row['client_id'],
        'amount': row['amount'].toString(),
        'notes': row['description'],
        'payment_date': row['date'],
        'type': 'payment',
      };
    }).toList();
  }

  Future<List<Map<String, dynamic>>> _getTransactions(
    String category,
    Map<String, dynamic>? query,
  ) async {
    final db = await _db;
    final page = _pageFrom(query);
    final typeFilter =
        category == 'debt'
            ? "WHERE type = 'debt'"
            : category == 'payment'
            ? "WHERE type = 'payment'"
            : '';

    final rows = await db.rawQuery(
      '''
      SELECT * FROM (
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
      )
      $typeFilter
      ORDER BY date DESC, id DESC
      LIMIT ? OFFSET ?
      ''',
      [_pageSize, (page - 1) * _pageSize],
    );

    return rows.map(_transactionApiMap).toList();
  }

  Future<Map<String, dynamic>> _getHomeView() async {
    final db = await _db;
    final balances = await db.rawQuery('''
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
    ''');

    final recentDebts = await db.rawQuery('''
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
    ''');

    final recentPayments = await db.rawQuery('''
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
    ''');

    final summary = balances.first;
    return {
      'balance': summary['balance'] ?? 0,
      'clients_count': summary['clients_count'] ?? 0,
      'clients_in_debt': summary['clients_in_debt'] ?? 0,
      'clients_clear': summary['clients_clear'] ?? 0,
      'recent_debts': recentDebts.map(_transactionApiMap).toList(),
      'recent_payments': recentPayments.map(_transactionApiMap).toList(),
    };
  }

  Map<String, dynamic> _debtApiMap(Map<String, dynamic> row) {
    return {
      'id': row['id'],
      'client_id': row['client_id'],
      'description': row['description'],
      'amount': row['amount'].toString(),
      'debt_date': row['debt_date'],
    };
  }

  Map<String, dynamic> _paymentApiMap(Map<String, dynamic> row) {
    return {
      'id': row['id'],
      'client_id': row['client_id'],
      'notes': row['notes'],
      'amount': row['amount'].toString(),
      'payment_date': row['payment_date'],
    };
  }

  Map<String, dynamic> _transactionApiMap(Map<String, dynamic> row) {
    return {
      'id': row['id'],
      'client_id': row['client_id'],
      'client': {'name': row['client_name']},
      'date': row['date'],
      'description': row['description'],
      'amount': row['amount'].toString(),
      'type': row['type'],
    };
  }

  bool _matchesClientCategory(Map<String, dynamic> row, String category) {
    final remaining = (row['remaining'] as num?)?.toDouble() ?? 0;
    return switch (category) {
      'debt' => remaining > 0,
      'clear' => remaining <= 0,
      'late' => remaining > 0,
      _ => true,
    };
  }

  int _pageFrom(Map<String, dynamic>? query) {
    final page = int.tryParse(query?['page']?.toString() ?? '') ?? 1;
    return page < 1 ? 1 : page;
  }

  String _now() {
    final value = DateTime.now().toLocal().toIso8601String();
    return value.substring(0, 19).replaceFirst('T', ' ');
  }

  Map<String, dynamic> _localAuthResult() {
    return {
      'result': {
        'user': {
          'id': 1,
          'name': 'مستخدم محلي',
          'email': 'offline@sajilha.local',
          'mobile': '',
        },
        'token': {'access_token': 'local'},
        'access_token': 'local',
      },
    };
  }
}
