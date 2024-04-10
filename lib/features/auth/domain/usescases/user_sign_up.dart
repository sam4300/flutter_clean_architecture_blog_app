import 'package:blog_app/core/error/failure_model.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<String, UserSignupParams> {
  final AuthRepository authRepository;

  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, String>> call(UserSignupParams params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  } 
}

class UserSignupParams {
  final String name;
  final String email;
  final String password;

  UserSignupParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
