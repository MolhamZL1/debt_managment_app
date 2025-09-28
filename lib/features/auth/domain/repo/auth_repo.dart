import 'package:dartz/dartz.dart';
import 'package:debt_managment_app/core/errors/failures.dart';

abstract class AuthRepo {
  Future<Either<Failure, void>> signIn(String email, String password);
  Future<Either<Failure, void>> signUp(
    String name,
    String phoneNumber,
    String email,
    String password,
    String passwordConfirmation,
  );
  Future<Either<Failure, void>> signOut();
}
