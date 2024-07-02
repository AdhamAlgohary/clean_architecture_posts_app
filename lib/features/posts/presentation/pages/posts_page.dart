import 'package:clean_architecture_posts_app/core/app_theme.dart';
import 'package:clean_architecture_posts_app/core/strings/app_strings.dart';
import 'package:clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_events.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_state.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/posts_page/list_of_posts_widget.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/posts_page/message_display_widget.dart';
import 'package:clean_architecture_posts_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatinBtn(
        context: context,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        titleInAppBar,
        style: TextStyle(color: secondaryColor),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
      if (state is LoadingPostsState) {
        return const LoadingWidget();
      } else if (state is LoadedPostsState) {
        return RefreshIndicator(
            onRefresh: () => _onRefresh(context),
            child: ListOfPostsWidget(posts: state.posts));
      } else if (state is ErrorPostsState) {
        return MessageDisplayWidget(
          message: state.message,
        );
      } else {
        return const LoadingWidget();
      }
    });
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }

  Widget _buildFloatinBtn({required BuildContext context}) {
    return FloatingActionButton(
      onPressed: () {
        final navigateToAddPostPage = RouteGenerator.generateRoute(
          const RouteSettings(name: '/addUpdatePostPage'),
        );
        Navigator.of(context).push(navigateToAddPostPage);
      },
      child: const Icon(Icons.add),
    );
  }
}
