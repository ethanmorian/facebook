import 'package:flutter_facebook/core/constants/app_colors.dart';
import 'package:flutter_facebook/core/screens/loader.dart';
import 'package:flutter_facebook/core/utils/utils.dart';
import 'package:flutter_facebook/features/chat/presentation/widgets/chats_user_info.dart';
import 'package:flutter_facebook/features/chat/presentation/widgets/messages_list.dart';
import 'package:flutter_facebook/features/chat/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatScreen extends ConsumerStatefulWidget {
  static const routeName = '/chat-screen';
  final String userId;

  const ChatScreen({
    super.key,
    required this.userId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  late final TextEditingController messageController;
  late final String chatroomId;

  @override
  void initState() {
    messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ref.watch(chatProvider).createChatroom(userId: widget.userId),
      builder: (
        context,
        snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        chatroomId = snapshot.data ?? 'No chatroom Id';

        return Scaffold(
          backgroundColor: AppColors.realWhiteColor,
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.messengerBlue,
              ),
            ),
            titleSpacing: 0,
            title: ChatUserInfo(userId: widget.userId),
          ),
          body: Column(
            children: [
              Expanded(
                child: MessagesList(chatroomId: chatroomId),
              ),
              const Divider(),
              _buildMessageInput(),
            ],
          ),
        );
      },
    );
  }

  // Chat Text Field
  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.image,
              color: AppColors.messengerDarkGrey,
            ),
            onPressed: () async {
              final image = await pickImage();
              if (image == null) return;
              await ref.read(chatProvider).sendFileMessage(
                    file: image,
                    chatroomId: chatroomId,
                    receiverId: widget.userId,
                    messageType: 'image',
                  );
            },
          ),
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.video,
              color: AppColors.messengerDarkGrey,
              size: 20,
            ),
            onPressed: () async {
              final video = await pickVideo();
              if (video == null) return;
              await ref.read(chatProvider).sendFileMessage(
                    file: video,
                    chatroomId: chatroomId,
                    receiverId: widget.userId,
                    messageType: 'video',
                  );
            },
          ),
          // Text Field
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.messengerGrey,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: messageController,
                decoration: const InputDecoration(
                  hintText: 'Aa',
                  hintStyle: TextStyle(),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 20,
                    bottom: 10,
                  ),
                ),
                textInputAction: TextInputAction.done,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.send,
              color: AppColors.messengerBlue,
            ),
            onPressed: () async {
              // Add functionality to handle send button press
              await ref.read(chatProvider).sendMessage(
                    message: messageController.text,
                    chatroomId: chatroomId,
                    receiverId: widget.userId,
                  );
              messageController.clear();
            },
          ),
        ],
      ),
    );
  }
}
