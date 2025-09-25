import 'package:dartz/dartz.dart';

import 'package:debt_managment_app/core/errors/failures.dart';
import 'package:debt_managment_app/core/services/database_service.dart';
import 'package:debt_managment_app/core/utils/backend_endpoints.dart';
import 'package:debt_managment_app/features/auth/data/model/user_model.dart';

import 'package:debt_managment_app/features/auth/domain/entity/user_entity.dart';
import 'package:dio/dio.dart';

import '../../domain/repo/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  final DatabaseService databaseService;

  AuthRepoImp({required this.databaseService});
  @override
  Future<Either<Failure, UserEntity>> signIn(
    String email,
    String password,
  ) async {
    try {
      final data = await databaseService.addData(
        endpoint: BackendEndPoint.signIn,
        data: {"email_or_mobile": email, "password": password},
      );
      final user = UserModel.fromJson(data);
      return Right(user.toEntity());
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(
    String name,
    String phoneNumber,
    String email,
    String password,
    String passwordConfirmation,
  ) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
