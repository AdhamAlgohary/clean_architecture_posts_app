import 'package:clean_architecture_posts_app/core/screen_size.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/pages/post_detail_page.dart';
import 'package:flutter/material.dart';

class ListOfPostsWidget extends StatelessWidget {
  final List<Post> posts;
  const ListOfPostsWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: 0.01 * screenHeight(context: context)),
      child: ListView.separated(
          itemBuilder: (_, index) => ListTile(
                leading: Text(
                  '${posts[index].id}',
                  style:
                      TextStyle(fontSize: 0.05 * screenWidth(context: context)),
                ),
                title: Text(
                  posts[index].body,
                  style:
                      TextStyle(fontSize: 0.05 * screenWidth(context: context)),
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => PostDetailPage(
                          post: posts[index],
                        ))),
              ),
          separatorBuilder: (_, index) => Divider(
                thickness: 0.01 * screenWidth(context: context),
              ),
          itemCount: posts.length),
    );
  }
}
