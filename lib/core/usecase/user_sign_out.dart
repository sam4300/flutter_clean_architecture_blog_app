import 'package:blog_app/core/error/failure_model.dart';
import 'package:blog_app/core/repository/auth_repository.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class UserSignOut implements UseCase<void, NoParams> {
  final AuthRepository authRepository;

  UserSignOut({
    required this.authRepository,
  });
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepository.userSignOut();
  }
}
