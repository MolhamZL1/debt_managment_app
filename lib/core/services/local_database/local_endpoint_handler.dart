typedef LocalAddHandler =
    Future<dynamic> Function(Map<String, dynamic>? data, String? rowid);
typedef LocalGetHandler =
    Future<dynamic> Function(String? rowid, Map<String, dynamic>? query);
typedef LocalDeleteHandler = Future<dynamic> Function(String? rowid);
typedef LocalUpdateHandler =
    Future<dynamic> Function(String? rowid, dynamic data);
