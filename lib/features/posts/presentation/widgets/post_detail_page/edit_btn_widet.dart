import 'package:clean_architecture_posts_app/core/app_theme.dart';
import 'package:clean_architecture_posts_app/core/strings/app_strings.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/pages/add_update_post_page.dart';
import 'package:flutter/material.dart';

class EditBtnWidget extends StatelessWidget {
  final Post post;
  const EditBtnWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.green)),
      onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => AddUpdatePostPage(
                isUpdated: true,
                post: post,
              ))),
      icon: const Icon(
        Icons.edit,
      ),
      label: const Text(
        editLabelInsideBtn,
        style: TextStyle(color: secondaryColor),
      ),
    );
  }
}
