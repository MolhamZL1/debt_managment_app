import 'package:dartz/dartz.dart';

import 'package:debt_managment_app/core/errors/failures.dart';
import 'package:debt_managment_app/core/services/database_service.dart';

import 'package:debt_managment_app/features/home/domain/entities/home_view_entity.dart';
import 'package:dio/dio.dart';

import '../../../../core/utils/backend_endpoints.dart';
import '../../domain/repo/home_view_repo.dart';
import '../models/home_view_model.dart';

class HomeViewRepoImp implements HomeViewRepo {
  final DatabaseService databaseService;

  HomeViewRepoImp({required this.databaseService});
  @override
  Future<Either<Failure, HomeViewEntity>> getHomeView() async {
    try {
      final data = await databaseService.getData(
        endpoint: BackendEndPoint.homeView,
      );

      HomeViewEntity homeViewEntity =
          HomeViewModel.fromJson(data["result"]).toEntity();
      return Right(homeViewEntity);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
