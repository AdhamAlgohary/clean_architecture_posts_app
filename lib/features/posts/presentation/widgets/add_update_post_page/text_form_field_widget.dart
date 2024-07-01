import 'package:clean_architecture_posts_app/core/screen_size.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool multiLines;
  final String name;
  const TextFormFieldWidget(
      {super.key,
      required this.controller,
      required this.multiLines,
      required this.name});

  @override
  Widget build(BuildContext context) {
    final heightOfScreen = screenHeight(context: context);
    final widthOfScreen = screenWidth(context: context);
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: 0.01 * heightOfScreen, horizontal: 0.1 * widthOfScreen),
        child: TextFormField(
          maxLines: multiLines ? 6 : 1,
          controller: controller,
          validator: (val) => val!.isEmpty ? "$name Can't be empty" : null,
          decoration: InputDecoration(hintText: name),
        ));
  }
}
