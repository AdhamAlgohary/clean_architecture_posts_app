import 'package:clean_architecture_posts_app/core/app_theme.dart';
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
    final screenOfHeight = screenHeight(context: context);
    final screenOfWidth = screenWidth(context: context);
    final orientationMode = MediaQuery.of(context).orientation;
    final landScapeOriantationCondition =
        orientationMode == Orientation.landscape;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.02 * screenOfHeight),
      child: ListView.separated(
        itemCount: posts.length,
        itemBuilder: (_, index) => ListTile(
            leadingAndTrailingTextStyle: landScapeOriantationCondition
                ? TextStyle(
                    fontSize: 0.037 * screenOfWidth, color: secondaryColor)
                : TextStyle(
                    fontSize: 0.05 * screenOfWidth, color: secondaryColor),
            titleTextStyle: landScapeOriantationCondition
                ? TextStyle(
                    fontSize: 0.03 * screenOfWidth, color: secondaryColor)
                : TextStyle(
                    fontSize: 0.05 * screenOfWidth, color: secondaryColor),
            leading: Text(
              '${posts[index].id}',
            ),
            title: Text(
              posts[index].body,
            ),
            onTap: () {
              BlocProvider.of<PostsBloc>(context).post = posts[index];
              Navigator.of(context).pushNamed(RouteGenerator.detailPostsPage);
            }),
        separatorBuilder: (_, __) => Divider(
          thickness: 0.01 * screenOfWidth,
        ),
      ),
    );
  }
}
