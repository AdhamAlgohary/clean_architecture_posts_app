import 'package:clean_architecture_posts_app/core/strings/app_strings.dart';
import 'package:clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
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
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
      if (state is LoadingPostsState) {
        return const LoadingWidget();
      } else if (state is LoadedPostsState) {
        BlocProvider.of<PostsBloc>(context).posts = state.posts;
        return RefreshIndicator(
            onRefresh: () => _onRefresh(context),
            child: const ListOfPostsWidget());
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
        BlocProvider.of<AddDeleteUpdatePostBloc>(context).isUpdated = false;
        Navigator.of(context)
            .pushNamed(RouteGenerator.addUpdatePostPage);
      },
      child: const Icon(Icons.add),
    );
  }
}
