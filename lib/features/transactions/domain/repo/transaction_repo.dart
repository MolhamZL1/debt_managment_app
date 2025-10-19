import 'package:dartz/dartz.dart';
import 'package:debt_managment_app/core/errors/failures.dart';
import 'package:debt_managment_app/features/transactions/domain/entities/transaction_entity.dart';

abstract class TransactionRepo {
  Future<Either<Failure, List<TransactionEntity>>> getAllTransactions({
    required String category,
  });
}
