import 'package:blog_app/core/error/failure_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, String>> signIpWithEmailPassword({
    required String email,
    required String password,
  });
}
