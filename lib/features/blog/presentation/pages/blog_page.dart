import 'package:blog_app/features/blog/presentation/bloc/blog_bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static blogPageRoute() => MaterialPageRoute(
        builder: (context) => const BlogPage(),
      );
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(
          BlogGetAllPosts(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddNewBlog()));
            },
            child: const Text('Add new blog'),
          )
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is BlogFetchSuccess) {
            return ListView.builder(
              itemCount: state.blog.length,
              itemBuilder: (BuildContext context, int index) {
                final singleBlog = state.blog[index];
                return Text(singleBlog.title);
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
