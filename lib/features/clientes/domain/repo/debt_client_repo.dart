import 'package:dartz/dartz.dart';
import 'package:debt_managment_app/core/entities/debt_entity.dart';

import '../../../../core/errors/failures.dart';

abstract class DebtClientRepo {
  Future<Either<Failure, void>> addDebtToClient(
    int clientId,
    double amount,
    String? description,
  );
  Future<Either<Failure, List<DebtEntity>>> getAllDebtsOfClient(int clientId);
  Future<Either<Failure, void>> deleteDebtFromClient(int debtId);
  Future<Either<Failure, void>> updateDebtFromClient(int debtId, double amount);
}
