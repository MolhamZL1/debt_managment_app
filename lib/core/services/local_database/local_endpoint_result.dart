abstract class LocalEndpointResult {
  static Future<Map<String, dynamic>> success(Future<dynamic> action) async {
    await action;
    return {'result': true};
  }

  static UnsupportedError unsupported(String endpoint) {
    return UnsupportedError('Local endpoint is not supported: $endpoint');
  }
}
