import 'package:clean_architecture_posts_app/core/strings/app_strings.dart';
import 'package:clean_architecture_posts_app/core/utils/snackbar_msg.dart';
import 'package:clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_state.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/add_update_post_page/form_widget.dart';
import 'package:clean_architecture_posts_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUpdatePostPage extends StatelessWidget {
  final bool isUpdated;
  final Post? post;
  const AddUpdatePostPage({super.key, required this.isUpdated, this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  AppBar _buildAppBar() {
    return AppBar(
        title: isUpdated
            ? const Text(
                updatePostTxt,
              )
            : const Text(
                addPostTxt,
              ));
  }

  Widget _buildBody() {
    return BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
        builder: (_, state) {
      if (state is AddDeleteUpdatePostLoading) {
        return const LoadingWidget();
      } else {
        return FormWidget(isUpdated: isUpdated, post: isUpdated ? post : null);
      }
    }, listener: (context, state) {
      if (state is MessageAddDeleteUpdatePostState) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouteGenerator.postsPage,
          (route) => false,
        );
        SnackbarMsg.showSnackBar(
            context: context,
            msg: isUpdated ? successUpdateProcees : successAddProcess,
            isSuccessSnacBar: true);
      } else if (state is ErrorAddDeleteUpdatePostState) {
        SnackbarMsg.showSnackBar(
            context: context, msg: failedProcess, isSuccessSnacBar: false);
      }
    });
  }
}
