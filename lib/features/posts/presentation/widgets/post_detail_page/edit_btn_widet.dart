import 'package:clean_architecture_posts_app/core/app_theme.dart';
import 'package:clean_architecture_posts_app/core/strings/app_strings.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routes.dart';

class EditBtnWidget extends StatelessWidget {
  const EditBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.green)),
      onPressed: () {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context).isUpdated = true;
        Navigator.of(context).pushNamed(RouteGenerator.addUpdatePostPage);
      },
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
