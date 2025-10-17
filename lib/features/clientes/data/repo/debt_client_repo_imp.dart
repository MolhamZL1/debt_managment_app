import 'package:dartz/dartz.dart';

import 'package:debt_managment_app/core/entities/debt_entity.dart';

import 'package:debt_managment_app/core/errors/failures.dart';
import 'package:debt_managment_app/core/models/debt_model.dart';
import 'package:debt_managment_app/core/services/database_service.dart';
import 'package:debt_managment_app/core/utils/backend_endpoints.dart';
import 'package:dio/dio.dart';

import '../../domain/repo/debt_client_repo.dart';

class DebtClientRepoImp implements DebtClientRepo {
  final DatabaseService databaseService;
  DebtClientRepoImp({required this.databaseService});
  @override
  Future<Either<Failure, void>> addDebtToClient(
    int clientId,
    double amount,
    String? description,
  ) async {
    try {
      await databaseService.addData(
        endpoint: BackendEndPoint.addDebt,
        data: {
          "client_id": clientId,
          "amount": amount,
          "description": description,
        },
      );

      return Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(errMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, void>> deleteDebtFromClient(int debtId) {
    // TODO: implement deleteDebtFromClient
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<DebtEntity>>> getAllDebtsOfClient(
    int clientId,
  ) async {
    try {
      final data = await databaseService.getData(
        endpoint: BackendEndPoint.debtsClient,
        rowid: clientId.toString(),
      );
      List<DebtEntity> debts = List<DebtEntity>.from(
        data["result"].map((e) => DebtModel.fromJson(e).toEntity()),
      );
      return Right(debts);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(errMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, void>> updateDebtFromClient(
    int debtId,
    double amount,
  ) {
    // TODO: implement updateDebtFromClient
    throw UnimplementedError();
  }
}
