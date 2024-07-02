import 'package:clean_architecture_posts_app/features/posts/presentation/pages/posts_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const postsPage = '/';
  static const addUpdatePostPage = '/addUpdatePostPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case postsPage:
        return MaterialPageRoute(builder: (_) => const PostsPage());
      // case addUpdatePostPage:
      //   return MaterialPageRoute(builder: (_) =>  const AddUpdatePostPage(isUpdated: null,));

      default:
        throw const FormatException('Route not found');
    }
  }
}
