import 'package:dartz/dartz.dart';
import 'package:debt_managment_app/features/clientes/domain/entities/client_entity.dart';

import '../../../../core/errors/failures.dart';

abstract class ClientesRepo {
  Future<Either<Failure, void>> addCliente(ClientEntity cliente);
  Future<Either<Failure, void>> deleteCliente(int clienteId);
  Future<Either<Failure, void>> updateCliente(
    int clienteId,
    String name,
    String phoneNumber,
    String email,
  );
  Future<Either<Failure, List<ClientEntity>>> getAllClientes();
}
