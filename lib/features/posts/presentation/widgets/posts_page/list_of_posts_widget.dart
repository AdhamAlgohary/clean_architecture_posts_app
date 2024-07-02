import 'package:clean_architecture_posts_app/core/screen_size.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_architecture_posts_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListOfPostsWidget extends StatelessWidget {
  const ListOfPostsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = BlocProvider.of<PostsBloc>(context).posts;
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: 0.01 * screenHeight(context: context)),
      child: ListView.separated(
        itemCount: posts.length,
        itemBuilder: (_, index) => ListTile(
            leading: Text(
              '${posts[index].id}',
              style: TextStyle(fontSize: 0.05 * screenWidth(context: context)),
            ),
            title: Text(
              posts[index].body,
              style: TextStyle(fontSize: 0.05 * screenWidth(context: context)),
            ),
            onTap: () {
              BlocProvider.of<PostsBloc>(context).post = posts[index];

              Navigator.of(context).pushNamed(RouteGenerator.detailPostsPage);
            }),
        separatorBuilder: (_, index) => Divider(
          thickness: 0.01 * screenWidth(context: context),
        ),
      ),
    );
  }
}
