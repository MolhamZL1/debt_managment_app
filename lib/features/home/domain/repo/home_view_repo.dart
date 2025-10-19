import 'package:dartz/dartz.dart';
import 'package:debt_managment_app/core/errors/failures.dart';
import 'package:debt_managment_app/features/home/domain/entities/home_view_entity.dart';

abstract class HomeViewRepo {
  Future<Either<Failure, HomeViewEntity>> getHomeView();
}
