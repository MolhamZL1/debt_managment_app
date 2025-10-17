import 'package:dartz/dartz.dart';
import 'package:debt_managment_app/core/entities/payment_entity.dart';
import 'package:debt_managment_app/core/errors/failures.dart';
import 'package:debt_managment_app/core/models/payment_model.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/payment_client_repo.dart';
import 'package:dio/dio.dart';

import '../../../../core/services/database_service.dart';
import '../../../../core/utils/backend_endpoints.dart';

class PaymentClientRepoImp implements PaymentClientRepo {
  final DatabaseService databaseService;

  PaymentClientRepoImp({required this.databaseService});
  @override
  Future<Either<Failure, void>> addPaymentToClient(
    int clientId,
    double amount,
    String? description,
  ) async {
    try {
      await databaseService.addData(
        endpoint: BackendEndPoint.addPayment,
        data: {"client_id": clientId, "amount": amount, "notes": description},
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
  Future<Either<Failure, void>> deletePaymentFromClient(int paymentId) {
    // TODO: implement deletePaymentFromClient
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PaymentEntity>>> getAllPaymentsOfClient(
    int clientId,
  ) async {
    try {
      final data = await databaseService.getData(
        endpoint: BackendEndPoint.paymentsClinet,
        rowid: clientId.toString(),
      );
      List<PaymentEntity> payments = List<PaymentEntity>.from(
        data["result"].map((e) => PaymentModel.fromJson(e).toEntity()),
      );
      return Right(payments);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(errMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, void>> updatePaymentFromClient(
    int paymentId,
    double amount,
  ) {
    // TODO: implement updatePaymentFromClient
    throw UnimplementedError();
  }
}
