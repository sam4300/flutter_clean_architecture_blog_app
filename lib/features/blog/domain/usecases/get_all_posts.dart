import 'package:blog_app/core/error/failure_model.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllPosts implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;

  GetAllPosts({required this.blogRepository});
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllPosts();
  }
}
