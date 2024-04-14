
import 'package:blog_app/core/error/failure_model.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/entity/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignIn implements UseCase<User, UserSignInParams> {
  final AuthRepository authRepository;
  UserSignIn({
    required this.authRepository,
  });
  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async {
    return authRepository.signInWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInParams {
  final String email;
  final String password;
  UserSignInParams({
    required this.email,
    required this.password,
  });
}
