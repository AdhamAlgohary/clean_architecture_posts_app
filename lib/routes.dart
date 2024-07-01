import 'package:clean_architecture_posts_app/features/posts/presentation/pages/add_update_post_page.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/pages/posts_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const _postsPage = '/';
  static const _addUpdatePostPage = '/addUpdatePostPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case _postsPage:
        return MaterialPageRoute(builder: (_) => const PostsPage());
      case _addUpdatePostPage:
        return MaterialPageRoute(builder: (_) => const AddUpdatePostPage());

      default:
        throw const FormatException('Route not found');
    }
  }
}
