abstract class LocalDatabaseHelpers {
  static const pageSize = 10;

  static int pageFrom(Map<String, dynamic>? query) {
    final page = int.tryParse(query?['page']?.toString() ?? '') ?? 1;
    return page < 1 ? 1 : page;
  }

  static int offsetFrom(Map<String, dynamic>? query) {
    return (pageFrom(query) - 1) * pageSize;
  }

  static int requiredId(String? rowid) {
    return int.parse(rowid!);
  }

  static String now() {
    final value = DateTime.now().toLocal().toIso8601String();
    return value.substring(0, 19).replaceFirst('T', ' ');
  }
}
