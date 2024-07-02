import 'package:clean_architecture_posts_app/core/app_theme.dart';
import 'package:clean_architecture_posts_app/core/strings/app_strings.dart';
import 'package:flutter/material.dart';

class FormSubmitBtnWidget extends StatelessWidget {
  final void Function() onPressed;
  final bool isUpdated;
  const FormSubmitBtnWidget(
      {super.key, required this.onPressed, required this.isUpdated});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: isUpdated
          ? const Icon(
              Icons.edit,
            )
          : const Icon(
              Icons.add,
            ),
      label: isUpdated
          ? const Text(
              editLabelInsideBtn,
            style: TextStyle(color: secondaryColor),
            )
          : const Text(
              addLabelInsideBtn,
              style: TextStyle(color: secondaryColor),

            ),
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(primaryColor)),
    );
  }
}
