import 'package:clean_architecture_posts_app/core/screen_size.dart';
import 'package:clean_architecture_posts_app/core/strings/app_strings.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/post_detail_page/delete_btn_widget.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/post_detail_page/edit_btn_widet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context: context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        titleInAppBarInPostDetailPage,
      ),
    );
  }

  Widget _buildBody({required BuildContext context}) {
    final heightOfScreen = screenHeight(context: context);
    final widthOfScreen = screenWidth(context: context);
    final post = BlocProvider.of<PostsBloc>(context).post;
    final orientationMode = MediaQuery.of(context).orientation;
    final landScapeOriantationCondition =
        orientationMode == Orientation.landscape;
    return ListView(
      padding: EdgeInsets.symmetric(
          vertical: 0.2 * heightOfScreen,
          horizontal: 0.1 * screenWidth(context: context)),
      children: [
        Text(
          post!.title,
          style: TextStyle(
              fontSize: 0.06 * widthOfScreen, fontWeight: FontWeight.bold),
        ),
        Divider(
          thickness: 0.008 * widthOfScreen,
          height: 0.05 * heightOfScreen,
        ),
        Text(
          post.body,
          style: TextStyle(
            fontSize: landScapeOriantationCondition
                ? 0.025 * widthOfScreen
                : 0.05 * widthOfScreen,
          ),
        ),
        Divider(
          thickness: 0.008 * widthOfScreen,
          height: 0.1 * heightOfScreen,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [EditBtnWidget(), DelteBtnWidget()],
        )
      ],
    );
  }
}
