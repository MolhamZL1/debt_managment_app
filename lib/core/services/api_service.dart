import 'package:debt_managment_app/core/services/token_storage.dart';
import 'package:dio/dio.dart';
import '../utils/backend_endpoints.dart';
import 'AuthInterceptor.dart';
import 'database_service.dart';

class ApiService implements DatabaseService {
  final Dio dio;

  ApiService()
    : dio = Dio(
        BaseOptions(
          baseUrl: BackendEndPoint.url,
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      ) {
    dio.interceptors.add(
      AuthInterceptor(dio: dio, tokenStorage: TokenStorage()),
    );
  }

  @override
  Future addData({
    required String endpoint,
    required Map<String, dynamic>? data,
    String? rowid,
  }) async {
    final Response res = await dio.post(endpoint + (rowid ?? ''), data: data);
    return res.data;
  }

  @override
  Future getData({
    required String endpoint,
    String? rowid,
    Map<String, dynamic>? quary,
  }) async {
    final Response res = await dio.get(
      endpoint + (rowid ?? ''),
      queryParameters: quary,
    );
    return res.data;
  }

  @override
  Future deleteData({required String endpoint, String? rowid}) async {
    final Response res = await dio.delete(endpoint + (rowid ?? ''));
    return res.data;
  }

  @override
  Future updateData({
    required String endpoint,
    String? rowid,
    dynamic data,
  }) async {
    final Response res = await dio.put(endpoint + (rowid ?? ''), data: data);
    return res.data;
  }
}
