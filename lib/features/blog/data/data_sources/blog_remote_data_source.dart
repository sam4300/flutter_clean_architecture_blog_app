import 'dart:io';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/blog/data/user_model/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);

  Future<String> uploadImageToStorage(File image, BlogModel blog);

  Future<List<BlogModel>> getAllPosts();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl({required this.supabaseClient});
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final res =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();
      return BlogModel.fromJson(res.first);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<String> uploadImageToStorage(File image, BlogModel blog) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(blog.id, image);

      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllPosts() async {
    try {
      final blogs =
          await supabaseClient.from('blogs').select('* , profiles (name)');
      return blogs
          .map((blog) =>
              BlogModel.fromJson(blog).copyWith(name: blog['profiles']['name']))
          .toList();
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
