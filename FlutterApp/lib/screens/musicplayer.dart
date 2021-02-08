import 'package:flutter/material.dart';

class MusicPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player'),
      ),
      body: Container(
        child: Center(
          child: Text('Music Player Page'),
        ),
      ),
    );
  }
}