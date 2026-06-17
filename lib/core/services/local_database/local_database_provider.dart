import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'local_database_schema.dart';

class LocalDatabaseProvider {
  static const _databaseName = 'sajilha_local.db';
  static const _databaseVersion = 1;

  Database? _database;

  Future<Database> get database async {
    _database ??= await _openDatabase();
    return _database!;
  }

  Future<Database> _openDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onConfigure: LocalDatabaseSchema.configure,
      onCreate: LocalDatabaseSchema.create,
    );
  }
}
