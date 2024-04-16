import 'dart:io';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_posts.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadingBlog;
  final GetAllPosts _getAllPosts;
  BlogBloc({
    required UploadBlog uploadingBlog,
    required GetAllPosts getAllPosts,
  })  : _uploadingBlog = uploadingBlog,
        _getAllPosts = getAllPosts,
        super(BlogInitial()) {
    on<BlogEvent>(
      (_, emit) => emit(
        BlogLoading(),
      ),
    );
    on<BlogUpload>(_uploadBlog);
    on<BlogGetAllPosts>(_getBlogs);
  }

  void _uploadBlog(
    BlogUpload event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _uploadingBlog(
      UploadBlogParams(
          posterId: event.posterId,
          title: event.title,
          content: event.content,
          topics: event.topics,
          image: event.image),
    );

    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogUploadSuccess()),
    );
  }

  void _getBlogs(
    BlogGetAllPosts event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _getAllPosts(NoParams());

    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(
        BlogFetchSuccess(blog: r),
      ),
    );
  }
}
