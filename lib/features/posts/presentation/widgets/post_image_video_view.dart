import 'package:flutter/material.dart';

import '/features/posts/presentation/widgets/network_video_view.dart';

class PostImageVideoView extends StatelessWidget {
  final String fileType;
  final String fileUrl;

  const PostImageVideoView({
    super.key,
    required this.fileType,
    required this.fileUrl,
  });

  @override
  Widget build(BuildContext context) {
    if (fileType == 'image') {
      return Image.network(fileUrl);
    } else {
      return NetworkVideoView(videoUrl: fileUrl);
    }
  }
}
