import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class TransactionClientRepo {
  Future<Either<Failure, List<dynamic>>> getAllTransactionsOfClient(
    int clientId,
  );
}
