import 'dart:io';

import 'package:blog_app/core/error/failure_model.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlog({required this.blogRepository});
  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      topics: params.topics,
      posterId: params.posterId,
    );
  }
}

class UploadBlogParams {
  final String posterId;
  final String title;
  final String content;
  final List<String> topics;
  final File image;

  UploadBlogParams({
    required this.posterId,
    required this.title,
    required this.content,
    required this.topics,
    required this.image,
  });
}
