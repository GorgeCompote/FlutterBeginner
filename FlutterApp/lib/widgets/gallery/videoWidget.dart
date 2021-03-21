import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class VideoScreenWidget extends StatefulWidget {
  
  final VideoPlayerController controller;
  bool initialized = false;
  VideoScreenWidget({Key key, this.controller, this.initialized}):super(key: key);
  @override
  _VideoScreenWidgetState createState() => _VideoScreenWidgetState();
}

class _VideoScreenWidgetState extends State<VideoScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.initialized
          ? Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: AspectRatio(
                  aspectRatio: widget.controller.value.aspectRatio,
                  child: VideoPlayer(widget.controller),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    if (widget.controller.value.isPlaying) {
                      widget.controller.pause();
                    } else {
                      widget.controller.play();
                    }
                  });
                },
                child: Icon(
                  widget.controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}