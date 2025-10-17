import 'package:dartz/dartz.dart';

import '../../../../core/entities/payment_entity.dart';
import '../../../../core/errors/failures.dart';

abstract class PaymentClientRepo {
  Future<Either<Failure, void>> addPaymentToClient(
    int clientId,
    double amount,
    String? description,
  );
  Future<Either<Failure, List<PaymentEntity>>> getAllPaymentsOfClient(
    int clientId,
  );
  Future<Either<Failure, void>> deletePaymentFromClient(int paymentId);
  Future<Either<Failure, void>> updatePaymentFromClient(
    int paymentId,
    double amount,
  );
}
