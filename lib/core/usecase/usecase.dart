import 'package:blog_app/core/error/failure_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<SuccesType, Params> {
  Future<Either<Failure, SuccesType>> call(Params params);
}
