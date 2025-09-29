import 'package:dartz/dartz.dart';
import 'package:debt_managment_app/core/errors/failures.dart';
import 'package:debt_managment_app/features/clientes/domain/entities/client_entity.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/clientes_repo.dart';

class ClientRepoImp implements ClientesRepo {
  @override
  Future<Either<Failure, void>> addCliente(ClientEntity cliente) {
    // TODO: implement addCliente
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteCliente(int clienteId) {
    // TODO: implement deleteCliente
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ClientEntity>>> getAllClientes() {
    // TODO: implement getAllClientes
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateCliente(int clienteId) {
    // TODO: implement updateCliente
    throw UnimplementedError();
  }
}
