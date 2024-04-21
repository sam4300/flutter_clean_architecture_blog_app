import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure_model.dart';
import 'package:blog_app/core/network/internet_connection_checker.dart';
import 'package:blog_app/features/auth/data/data_sources/auth_remote_dart_source.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/core/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ConnectionChecker connectionChecker;
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl(
    this.remoteDataSource,
    this.connectionChecker,
  );
  @override
  Future<Either<Failure, UserModel>> signInWithEmailPassword(
      {required String email, required String password}) async {
    return _getUser(
      () async => await remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    final currentUser = remoteDataSource.currentUserSession;
    try {
      if (!await connectionChecker.isConnected) {
        if (currentUser == null) {
          return left(Failure('no internet connection'));
        }
        return right(UserModel(
          id: currentUser.user.id,
          name: '',
          email: currentUser.user.email ?? '',
        ));
      }
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(
          Failure('User not logged in'),
        );
      }
      return right(user);
    } on ServerException catch (e) {
      return left(
        Failure(e.message),
      );
    }
  }

  Future<Either<Failure, UserModel>> _getUser(
    Future<UserModel> Function() fn,
  ) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(
          Failure('No Internet Connection'),
        );
      }
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(
        Failure(e.message),
      );
    }
  }

  @override
  Future<Either<Failure, void>> userSignOut() async {
    try {
      return right(
        remoteDataSource.userSignOut(),
      );
    } on ServerException catch (e) {
      return left(
        Failure(e.message),
      );
    }
  }
}
