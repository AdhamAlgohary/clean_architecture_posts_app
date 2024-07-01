import 'package:clean_architecture_posts_app/core/app_theme.dart';
import 'package:clean_architecture_posts_app/core/screen_size.dart';
import 'package:clean_architecture_posts_app/core/strings/app_strings.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/post_detail_page/delete_btn_widget.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/post_detail_page/edit_btn_widet.dart';
import 'package:flutter/material.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;
  const PostDetailPage({super.key, required this.post});

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
        style: TextStyle(color: secondaryColor),
      ),
    );
  }

  Widget _buildBody({required BuildContext context}) {
    final heightOfScreen = screenHeight(context: context);
    final widthOfScreen = screenWidth(context: context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            post.title,
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
              fontSize: 0.05 * widthOfScreen,
            ),
          ),
          Divider(
            thickness: 0.008 * widthOfScreen,
            height: 0.05 * heightOfScreen,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              EditBtnWidget(
                post: post,
              ),
              DelteBtnWidget(
                postId: post.id!,
              )
            ],
          )
        ],
      ),
    );
  }
}
