import 'package:debt_managment_app/core/services/get_it_service.dart';
import 'package:dio/dio.dart';

import '../../features/auth/domain/repo/auth_repo.dart';
import '../utils/backend_endpoints.dart';
import 'token_storage.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final TokenStorage tokenStorage;

  AuthInterceptor({required this.dio, required this.tokenStorage});

  bool _isPublicAuthCall(String path) {
    return path.contains(BackendEndPoint.signIn) ||
        path.contains(BackendEndPoint.signUp) ||
        path.contains(BackendEndPoint.resendCode) ||
        path.contains(BackendEndPoint.verifyforgetpasswordCode) ||
        path.contains(BackendEndPoint.resetPassword) ||
        path.contains(BackendEndPoint.forgotPassword);
  }

  bool _isRefreshCall(String path) {
    return path.contains(BackendEndPoint.refresh);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final accessToken = await tokenStorage.readAccess();
      final isPublicAuth = _isPublicAuthCall(options.path);

      if (!isPublicAuth &&
          accessToken != null &&
          accessToken.isNotEmpty &&
          options.headers['Authorization'] == null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
      return handler.next(options);
    } catch (e) {
      return handler.next(options);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final path = err.requestOptions.path;

    if (err.response?.statusCode == 401 &&
        !_isPublicAuthCall(path) &&
        !_isRefreshCall(path)) {
      final requestOptions = err.requestOptions;

      final alreadyRetried = requestOptions.extra['__retried'] == true;
      if (alreadyRetried) {
        return handler.next(err);
      }

      try {
        final oldToken = await tokenStorage.readAccess();
        if (oldToken == null) {
          return handler.next(err);
        }

        final result = await getIt.get<AuthRepo>().refresh();

        return result.fold(
          (failure) {
            return handler.next(err);
          },
          (newToken) async {
            await tokenStorage.saveAccess(newToken);

            requestOptions.extra['__retried'] = true;

            requestOptions.headers['Authorization'] = 'Bearer $newToken';

            final response = await dio.fetch(requestOptions);
            return handler.resolve(response);
          },
        );
      } catch (e) {
        return handler.next(err);
      }
    }

    // أي شيء آخر: مرر الخطأ كما هو
    return handler.next(err);
  }
}
