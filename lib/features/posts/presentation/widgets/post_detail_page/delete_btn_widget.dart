import 'package:clean_architecture_posts_app/core/app_theme.dart';
import 'package:clean_architecture_posts_app/core/strings/app_strings.dart';
import 'package:clean_architecture_posts_app/core/utils/snackbar_msg.dart';
import 'package:clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_state.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/post_detail_page/delete_dialog_widget.dart';
import 'package:clean_architecture_posts_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DelteBtnWidget extends StatelessWidget {
  final int postId;
  const DelteBtnWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: const ButtonStyle(
          overlayColor: MaterialStatePropertyAll<Color>(Colors.red),
          backgroundColor: MaterialStatePropertyAll(Colors.redAccent)),
      onPressed: () => _deleteDialog(context, postId),
      icon: const Icon(
        Icons.delete_outline_sharp,
      ),
      label: const Text(
        deleteLabelInsideBtn,
        style: TextStyle(color: secondaryColor),
      ),
    );
  }

  void _deleteDialog(BuildContext context, int postId) {
    showDialog(
      context: context,
      builder: (_) =>
          BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
              builder: (_, state) {
        if (state is AddDeleteUpdatePostLoading) {
          return const AlertDialog(
            title: LoadingWidget(),
          );
        } else {
          return DeleteDialogWidget(
            postId: postId,
          );
        }
      }, listener: (_, state) {
        if (state is ErrorAddDeleteUpdatePostState) {
          Navigator.of(context).pop();
          SnackbarMsg.showSnackBar(
              context: context, msg: state.message, isSuccessSnacBar: false);
        } else if (state is MessageAddDeleteUpdatePostState) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              RouteGenerator.postsPage, (route) => false);
          SnackbarMsg.showSnackBar(
              context: context, msg: state.message, isSuccessSnacBar: true);
        }
      }),
    );
  }
}
