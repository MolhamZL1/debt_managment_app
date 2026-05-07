import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _kAccess = 'access_token';
  final _secure = const FlutterSecureStorage();

  Future<String?> readAccess() => _secure.read(key: _kAccess);

  Future<void> saveAccess(String access) =>
      _secure.write(key: _kAccess, value: access);
  Future<void> clear() async {
    await _secure.delete(key: _kAccess);
  }
}
