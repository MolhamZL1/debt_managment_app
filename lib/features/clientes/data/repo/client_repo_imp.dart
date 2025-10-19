import 'package:dartz/dartz.dart';
import 'package:debt_managment_app/core/errors/failures.dart';
import 'package:debt_managment_app/core/utils/backend_endpoints.dart';
import 'package:debt_managment_app/features/clientes/data/model/client_model.dart';
import 'package:debt_managment_app/features/clientes/domain/entities/client_entity.dart';
import 'package:debt_managment_app/features/clientes/domain/repo/clientes_repo.dart';
import 'package:dio/dio.dart';

import '../../../../core/services/database_service.dart';

class ClientRepoImp implements ClientesRepo {
  final DatabaseService databaseService;

  ClientRepoImp({required this.databaseService});
  @override
  Future<Either<Failure, void>> addCliente({
    required String name,
    String? address,
    String? phone,
  }) async {
    try {
      await databaseService.addData(
        endpoint: BackendEndPoint.addClient,
        data: {"name": name, "address": address, "phone": phone},
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
  Future<Either<Failure, void>> deleteCliente(int clienteId) {
    // TODO: implement deleteCliente
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ClientEntity>>> getAllClientes({
    required String category,
  }) async {
    try {
      final data = await databaseService.getData(
        endpoint: BackendEndPoint.clientes,
        rowid: category,
      );
      List<ClientEntity> clientes = List<ClientEntity>.from(
        data["result"].map((e) => ClientModel.fromJson(e).toEntity()),
      );
      return Right(clientes);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ClientEntity>> getCliente({
    required int clientId,
  }) async {
    try {
      final data = await databaseService.getData(
        endpoint: BackendEndPoint.clienteData,
        rowid: clientId.toString(),
      );
      ClientEntity cliente = ClientModel.fromJson(data["result"]).toEntity();
      return Right(cliente);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateCliente(int clienteId) {
    // TODO: implement updateCliente
    throw UnimplementedError();
  }
}
