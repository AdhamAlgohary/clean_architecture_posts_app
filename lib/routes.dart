import 'package:clean_architecture_posts_app/features/posts/presentation/pages/add_update_post_page.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/pages/post_detail_page.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/pages/posts_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const postsPage = '/';
  static const addUpdatePostPage = '/addUpdatePostPage';
  static const detailPostsPage = '/detailPostsPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case postsPage:
        return MaterialPageRoute(builder: (_) => const PostsPage());
      case addUpdatePostPage:
        return MaterialPageRoute(builder: (_) => const AddUpdatePostPage());
      case detailPostsPage:
        return MaterialPageRoute(builder: (_) => const PostDetailPage());

      default:
        throw const FormatException('Route not found');
    }
  }
}
