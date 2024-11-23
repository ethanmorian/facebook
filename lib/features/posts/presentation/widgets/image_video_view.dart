import 'dart:io';

import 'package:facebook/features/posts/presentation/widgets/video_view.dart';
import 'package:flutter/material.dart';

class ImageVideoView extends StatelessWidget {
  final String fileType;
  final File file;

  const ImageVideoView({
    super.key,
    required this.fileType,
    required this.file,
  });

  @override
  Widget build(BuildContext context) {
    if (fileType == 'image') {
      return Image.file(
        file,
      );
    } else {
      return VideoView(
        video: file,
      );
    }
  }
}
