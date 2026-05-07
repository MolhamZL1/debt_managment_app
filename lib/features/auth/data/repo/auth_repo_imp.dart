import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:debt_managment_app/core/errors/failures.dart';
import 'package:debt_managment_app/core/services/database_service.dart';
import 'package:debt_managment_app/core/services/local_storage_service.dart';
import 'package:debt_managment_app/core/utils/backend_endpoints.dart';
import 'package:debt_managment_app/core/services/token_storage.dart';

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
      await LocalStorageService.setItem(
        LocalStorageKeys.user,
        jsonEncode(data["result"]["user"]),
      );

      await TokenStorage().saveAccess(data["result"]["token"]['access_token']);
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
      await databaseService.addData(
        endpoint: BackendEndPoint.signUp,
        data: {
          "name": name,
          "mobile": phoneNumber,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
      );
      return Right(null);
    } catch (e) {
      log(e.toString());
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
      await TokenStorage().clear();
      return Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> refresh() async {
    try {
      final data = await databaseService.addData(
        endpoint: BackendEndPoint.refresh,
        data: {},
      );
      String accessToken = data["result"]['access_token'];

      return Right(accessToken);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> verfyEmail({
    required String code,
    required String email,
  }) async {
    try {
      await databaseService.addData(
        endpoint: BackendEndPoint.activeCode,
        data: {"email": email, "code": code},
      );
      return Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resendVerficationCode({
    required String email,
  }) async {
    try {
      await databaseService.addData(
        endpoint: BackendEndPoint.resendCode,
        data: {"email": email},
      );
      return Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> forgetPassword({required String email}) async {
    try {
      await databaseService.addData(
        endpoint: BackendEndPoint.forgotPassword,
        data: {"email": email},
      );
      return Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> checkCodeResetPassword({
    required String code,
    required String email,
  }) async {
    try {
      await databaseService.addData(
        endpoint: BackendEndPoint.verifyforgetpasswordCode,
        data: {"email": email, "code": code},
      );
      return Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String password,
    required String passwordConfirmation,
    required String email,
  }) async {
    try {
      await databaseService.addData(
        endpoint: BackendEndPoint.resetPassword,
        data: {
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
      );
      return Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
