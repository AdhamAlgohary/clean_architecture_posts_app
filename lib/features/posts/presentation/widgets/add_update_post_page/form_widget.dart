import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_event.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/add_update_post_page/form_submit_btn_widget.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/add_update_post_page/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdated;
  final Post? post;
  const FormWidget({super.key, required this.isUpdated, this.post});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.isUpdated) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWidget(
              controller: _titleController,
              name: 'Title',
              multiLines: false,
            ),
            TextFormFieldWidget(
              controller: _bodyController,
              name: 'Body',
              multiLines: true,
            ),
            FormSubmitBtnWidget(
              onPressed: _validateFormThenAddOrUpdatePost,
              isUpdated: widget.isUpdated,
            ),
          ],
        ));
  }

  void _validateFormThenAddOrUpdatePost() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final post = Post(
          id: widget.isUpdated ? widget.post!.id : null,
          title: _titleController.text,
          body: _bodyController.text);
      if (widget.isUpdated) {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(UpdatePostEvent(posts: post));
      } else {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(AddPostEvent(posts: post));
      }
    }
  }
}
