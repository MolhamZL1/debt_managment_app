import 'package:dartz/dartz.dart';

import 'package:debt_managment_app/core/errors/failures.dart';
import 'package:debt_managment_app/core/services/database_service.dart';
import 'package:debt_managment_app/core/utils/backend_endpoints.dart';
import 'package:debt_managment_app/core/utils/token_storage.dart';

import 'package:dio/dio.dart';

import '../../domain/repo/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  final DatabaseService databaseService;

  AuthRepoImp({required this.databaseService});
  @override
  Future<Either<Failure, void>> signIn(String email, String password) async {
    try {
      final data = await databaseService.addData(
        endpoint: BackendEndPoint.signIn,
        data: {"email_or_mobile": email, "password": password},
      );
      TokenStorage().saveAccess(data["result"]["token"]['access_token']);
      return Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signUp(
    String name,
    String phoneNumber,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    try {
      final data = await databaseService.addData(
        endpoint: BackendEndPoint.signIn,
        data: {
          "name": name,
          "mobile": phoneNumber,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
      );
      TokenStorage().saveAccess(data["result"]["token"]['access_token']);
      return Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await databaseService.addData(
        endpoint: BackendEndPoint.signOut,
        data: {},
      );
      TokenStorage().clear();
      return Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
