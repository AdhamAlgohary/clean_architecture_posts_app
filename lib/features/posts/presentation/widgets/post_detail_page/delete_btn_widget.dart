import 'package:clean_architecture_posts_app/core/app_theme.dart';
import 'package:clean_architecture_posts_app/core/strings/app_strings.dart';
import 'package:clean_architecture_posts_app/core/utils/snackbar_msg.dart';
import 'package:clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_state.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/post_detail_page/delete_dialog_widget.dart';
import 'package:clean_architecture_posts_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DelteBtnWidget extends StatelessWidget {
  const DelteBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final postId = BlocProvider.of<PostsBloc>(context).post!.id;
    return ElevatedButton.icon(
      style: const ButtonStyle(
          overlayColor: MaterialStatePropertyAll<Color>(Colors.red),
          backgroundColor: MaterialStatePropertyAll(Colors.redAccent)),
      onPressed: () => _deleteDialog(context, postId!),
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
        switch (state) {
          case AddDeleteUpdatePostLoading _:
            return const AlertDialog(
              title: LoadingWidget(),
            );

          default:
            return DeleteDialogWidget(
              postId: postId,
            );
        }
      }, listener: (_, state) {
        switch (state) {
          case ErrorAddDeleteUpdatePostState _:
            Navigator.of(context).pop();
            SnackbarMsg.showSnackBar(
                context: context, msg: state.message, isSuccessSnacBar: false);

            break;
          case MessageAddDeleteUpdatePostState _:
            Navigator.of(context).pushNamedAndRemoveUntil(
                RouteGenerator.postsPage, (route) => false);
            SnackbarMsg.showSnackBar(
                context: context, msg: state.message, isSuccessSnacBar: true);
            break;
          default:
        }
        
      }),
    );
  }
}
