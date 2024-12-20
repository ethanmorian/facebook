import 'package:flutter_facebook/features/chat/presentation/widgets/message_contents.dart';
import 'package:flutter_facebook/features/posts/presentation/widgets/round_profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/constants/app_colors.dart';
import '/features/chat/models/message.dart';
import '../../../auth/providers/get_user_info_by_id_provider.dart';

class ReceivedMessage extends ConsumerWidget {
  final Message message;

  const ReceivedMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(getUserInfoByIdProvider(message.senderId));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          userInfo.when(
            data: (user) {
              return RoundProfileTile(url: user.profilePicUrl);
            },
            error: (error, stackTrace) => const Icon(Icons.error),
            loading: () => const CircularProgressIndicator(),
          ),
          const SizedBox(width: 15),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: const BoxDecoration(
                color: AppColors.messengerGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: MessageContents(message: message),
            ),
          ),
        ],
      ),
    );
  }
}
