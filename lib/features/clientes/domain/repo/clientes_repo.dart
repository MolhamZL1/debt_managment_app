import 'package:dartz/dartz.dart';
import 'package:debt_managment_app/features/clientes/domain/entities/client_entity.dart';

import '../../../../core/errors/failures.dart';

abstract class ClientesRepo {
  Future<Either<Failure, void>> addCliente({
    required String name,
    String? address,
    String? phone,
  });
  Future<Either<Failure, void>> deleteCliente(int clienteId);
  Future<Either<Failure, void>> updateCliente(int clienteId);
  Future<Either<Failure, List<ClientEntity>>> getAllClientes();
}
