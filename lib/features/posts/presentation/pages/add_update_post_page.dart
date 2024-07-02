import 'package:clean_architecture_posts_app/core/strings/app_strings.dart';
import 'package:clean_architecture_posts_app/core/utils/snackbar_msg.dart';
import 'package:clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_state.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/add_update_post_page/form_widget.dart';
import 'package:clean_architecture_posts_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/posts/posts_bloc.dart';

class AddUpdatePostPage extends StatelessWidget {
  const AddUpdatePostPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody(context));
  }

  AppBar _buildAppBar(BuildContext context) {
    final isUpdated =
        BlocProvider.of<AddDeleteUpdatePostBloc>(context).isUpdated;
    return AppBar(
        title: isUpdated!
            ? const Text(
                updatePostTxt,
              )
            : const Text(
                addPostTxt,
              ));
  }

  Widget _buildBody(BuildContext context) {
    final isUpdated =
        BlocProvider.of<AddDeleteUpdatePostBloc>(context).isUpdated;
    final post = BlocProvider.of<PostsBloc>(context).post;

    return BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
        builder: (_, state) {
      switch (state) {
        case AddDeleteUpdatePostLoading _:
          return const LoadingWidget();
        default:
          return FormWidget(
              isUpdated: isUpdated!, post: isUpdated ? post : null);
      }
    }, listener: (context, state) {
      switch (state) {
        case MessageAddDeleteUpdatePostState _:
          {
            Navigator.of(context).pushNamedAndRemoveUntil(
              RouteGenerator.postsPage,
              (route) => false,
            );
            SnackbarMsg.showSnackBar(
                context: context,
                msg: isUpdated! ? successUpdateProcees : successAddProcess,
                isSuccessSnacBar: true);
            break;
          }
        case ErrorAddDeleteUpdatePostState _:
          SnackbarMsg.showSnackBar(
              context: context, msg: failedProcess, isSuccessSnacBar: false);
          break;
        default:
      }
    });
  }
}
