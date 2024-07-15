import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    _videoPlayerController = VideoPlayerController.asset('assets/ph.mp4');

    // Initialize ChewieController for controlling the video playback
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true, // Auto play the video on initialization
      looping: false, // Loop the video when it reaches the end
      showControls: false, // Hide player controls initially
      allowPlaybackSpeedChanging: false,
      allowFullScreen: true,
      aspectRatio: 16 / 9, // Set aspect ratio to 16:9 or adjust as needed
    );

    // Listen to video playback completion
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.isInitialized &&
          !_videoPlayerController.value.isPlaying &&
          (_videoPlayerController.value.duration == _videoPlayerController.value.position)) {
        // Video playback is completed, navigate to the intro page
        Navigator.pushReplacementNamed(context, '/intro');
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.removeListener(() {});
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Page'),
      ),
      body: Center(
        child: Chewie(controller: _chewieController),
      ),
    );
  }
}
