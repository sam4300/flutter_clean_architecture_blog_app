import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure_model.dart';
import 'package:blog_app/features/auth/data/data_sources/auth_remote_dart_source.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDateSource remoteDataSource;
  AuthRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, String>> signIpWithEmailPassword(
      {required String email, required String password}) {
    // TODO: implement signIpWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userId = await remoteDataSource.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
