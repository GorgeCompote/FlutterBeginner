import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';
import 'package:multimedia_app/widgets/gallery/videoWidget.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({
    Key key,
    @required this.videoFile,
  }) : super(key: key);

  final Future<File> videoFile;

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController _controller;
  bool initialized = false;

  @override
  void initState() {
    _initVideo();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _initVideo() async {
    final video = await widget.videoFile;
    _controller = VideoPlayerController.file(video)
      ..setLooping(true)
      ..initialize().then((_) => setState(() => initialized = true));
  }

   Widget build(BuildContext context){
     return VideoScreenWidget(controller: _controller, initialized: initialized);
   }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: initialized
  //         ? Scaffold(
  //             body: Center(
  //               child: AspectRatio(
  //                 aspectRatio: _controller.value.aspectRatio,
  //                 child: VideoPlayer(_controller),
  //               ),
  //             ),
  //             floatingActionButton: FloatingActionButton(
  //               onPressed: () {
  //                 setState(() {
  //                   if (_controller.value.isPlaying) {
  //                     _controller.pause();
  //                   } else {
  //                     _controller.play();
  //                   }
  //                 });
  //               },
  //               child: Icon(
  //                 _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
  //               ),
  //             ),
  //           )
  //         : Center(child: CircularProgressIndicator()),
  //   );
  // }
}