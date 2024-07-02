import 'package:clean_architecture_posts_app/core/app_theme.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_events.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/pages/posts_page.dart';
import 'package:clean_architecture_posts_app/injection_container.dart' as ic;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ic.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ic.gi<PostsBloc>()..add(GetAllPostsEvent()),
          ),
          BlocProvider(create: (_) => ic.gi<AddDeleteUpdatePostBloc>())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            home: const PostsPage()));
  }
}
