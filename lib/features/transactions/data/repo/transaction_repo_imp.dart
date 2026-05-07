import 'package:dartz/dartz.dart';

import 'package:debt_managment_app/core/errors/failures.dart';
import 'package:debt_managment_app/core/services/database_service.dart';
import 'package:debt_managment_app/features/transactions/data/models/transaction_model.dart';

import 'package:debt_managment_app/features/transactions/domain/entities/transaction_entity.dart';
import 'package:dio/dio.dart';

import '../../../../core/utils/backend_endpoints.dart';
import '../../domain/repo/transaction_repo.dart';

class TransactionRepoImp implements TransactionRepo {
  final DatabaseService databaseService;

  TransactionRepoImp({required this.databaseService});
  @override
  Future<Either<Failure, List<TransactionEntity>>> getAllTransactions({
    required String category,
    int page = 1,
  }) async {
    try {
      final data = await databaseService.getData(
        endpoint: BackendEndPoint.transaction,
        rowid: category,
        quary: {"page": page},
      );
      List<TransactionEntity> transactions = List<TransactionEntity>.from(
        data["result"].map((e) => TransactionModel.fromJson(e).toEntity()),
      );
      return Right(transactions);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
