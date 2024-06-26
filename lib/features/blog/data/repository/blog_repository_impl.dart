import 'dart:io';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure_model.dart';
import 'package:blog_app/core/network/internet_connection_checker.dart';
import 'package:blog_app/features/blog/data/data_sources/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/user_model/blog_model.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final ConnectionChecker connectionChecker;
  final BlogLocalDataSource blogLocalDataSource;
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImpl(
    this.blogRemoteDataSource,
    this.connectionChecker,
    this.blogLocalDataSource,
  );
  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required List<String> topics,
    required String posterId,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(
          'No internt connection',
        ));
      }
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        title: title,
        content: content,
        updatedAt: DateTime.now(),
        imageUrl: '',
        topics: topics,
        posterId: posterId,
      );

      final imageUrl =
          await blogRemoteDataSource.uploadImageToStorage(image, blogModel);

      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      final updatedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return right(updatedBlog);
    } on ServerException catch (e) {
      return left(
        Failure(e.message),
      );
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllPosts() async {
    try {
      if (!await connectionChecker.isConnected) {
        final res = blogLocalDataSource.getLocalBlogs();
        return right(res);
      }
      final res = await blogRemoteDataSource.getAllPosts();
      blogLocalDataSource.uploadLocalBlogs(blogs: res);
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
