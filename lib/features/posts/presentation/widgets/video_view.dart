import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final File video;

  const VideoView({
    super.key,
    required this.video,
  });

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late final VideoPlayerController _videoController;

  bool isPlaying = false;

  @override
  void initState() {
    _videoController = VideoPlayerController.file(widget.video)
      ..initialize().then((value) {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _videoController.value.aspectRatio,
      child: Stack(
        children: [
          VideoPlayer(_videoController),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                if (isPlaying) {
                  _videoController.pause();
                } else {
                  _videoController.play();
                }
                isPlaying = !isPlaying;
                setState(() {});
              },
              child: Icon(
                isPlaying ? Icons.pause_circle : Icons.play_circle,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
