import 'package:facebook/features/posts/presentation/widgets/comment_text_field.dart';
import 'package:facebook/features/posts/presentation/widgets/comments_list.dart';
import 'package:flutter/material.dart';

class CommentsScreen extends StatelessWidget {
  static const routeName = '/comments';

  final String postId;

  const CommentsScreen({
    super.key,
    required this.postId,
  });

  // hello world

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          // Comments List
          CommentsList(postId: postId),

          // Comment Text field
          CommentTextField(postId: postId),
        ],
      ),
    );
  }
}
