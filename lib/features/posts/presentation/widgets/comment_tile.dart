import 'package:facebook/core/constants/app_colors.dart';
import 'package:facebook/core/constants/extensions.dart';
import 'package:facebook/core/screens/error_screen.dart';
import 'package:facebook/core/screens/loader.dart';
import 'package:facebook/features/auth/providers/get_user_info_by_id_provider.dart';
import 'package:facebook/features/posts/models/comment.dart';
import 'package:facebook/features/posts/presentation/widgets/round_like_icon.dart';
import 'package:facebook/features/posts/presentation/widgets/round_profile_tile.dart';
import 'package:facebook/features/posts/providers/posts_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;

  const CommentTile({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Comment header
          CommentHeader(comment: comment),

          // Comment Footer
          CommentFooter(comment: comment),
        ],
      ),
    );
  }
}

class CommentHeader extends ConsumerWidget {
  final Comment comment;

  const CommentHeader({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(
      getUserInfoByIdProvider(comment.authorId),
    );

    return userInfo.when(
      data: (user) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundProfileTile(url: user.profilePicUrl),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(comment.text),
                  ],
                ),
              ),
            )
          ],
        );
      },
      error: (error, stackTrace) {
        return ErrorScreen(error: error.toString());
      },
      loading: () {
        return const Loader();
      },
    );
  }
}

class CommentFooter extends StatelessWidget {
  final Comment comment;

  const CommentFooter({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    final isLiked =
        comment.likes.contains(FirebaseAuth.instance.currentUser!.uid);

    return Consumer(
      builder: (
        context,
        ref,
        child,
      ) {
        return Row(
          children: [
            Text(comment.createdAt.fromNow()),
            TextButton(
              onPressed: () async {
                await ref.read(postsProvider).likeDislikeComment(
                      commentId: comment.commentId,
                      likes: comment.likes,
                    );
              },
              child: Text(
                'like',
                style: TextStyle(
                    color: isLiked
                        ? AppColors.blueColor
                        : AppColors.darkGreyColor),
              ),
            ),
            const SizedBox(width: 15),
            const RoundLikeIcon(),
            const SizedBox(width: 5),
            Text(comment.likes.length.toString()),
          ],
        );
      },
    );
  }
}
