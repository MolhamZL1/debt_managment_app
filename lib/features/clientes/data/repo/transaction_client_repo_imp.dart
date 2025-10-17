import 'package:dartz/dartz.dart';
import 'package:debt_managment_app/core/errors/failures.dart';
import 'package:debt_managment_app/core/models/payment_model.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/transaction_client_repo.dart';
import 'package:dio/dio.dart';

import '../../../../core/models/debt_model.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/utils/backend_endpoints.dart';

class TransactionClientRepoImp implements TransactionClientRepo {
  final DatabaseService databaseService;

  TransactionClientRepoImp({required this.databaseService});
  @override
  Future<Either<Failure, List>> getAllTransactionsOfClient(int clientId) async {
    try {
      final data = await databaseService.getData(
        endpoint: BackendEndPoint.transactions,
        rowid: clientId.toString(),
      );
      List transactions = [];
      for (var element in data["result"]) {
        if (element["type"] == "debt") {
          transactions.add(DebtModel.fromJson(element).toEntity());
        } else {
          transactions.add(PaymentModel.fromJson(element).toEntity());
        }
      }

      return Right(transactions);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(errMessage: e.toString()));
      }
    }
  }
}
