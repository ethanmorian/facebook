import 'package:flutter_facebook/core/constants/app_colors.dart';
import 'package:flutter_facebook/core/screens/error_screen.dart';
import 'package:flutter_facebook/core/screens/loader.dart';
import 'package:flutter_facebook/features/auth/providers/get_user_info_by_id_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatUserInfo extends ConsumerWidget {
  final String userId;

  const ChatUserInfo({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(
      getUserInfoByIdProvider(userId),
    );

    return userInfo.when(
      data: (user) {
        return Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(user.profilePicUrl),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),
                ),
                const Text(
                  'Messenger',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.greyColor,
                  ),
                )
              ],
            ),
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
