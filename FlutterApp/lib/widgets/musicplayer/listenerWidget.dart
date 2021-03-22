import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';


class Listener extends StatefulWidget {
  Listener({Key key}):super(key: key);
  @override
  _ListenerState createState() => _ListenerState();
}

class _ListenerState extends State<Listener> {
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue[600],
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_sharp,
              )),
          title: Text('Now Playing'),
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(5, 25, 5, 0),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              CircleAvatar(
                backgroundImage: widget.songInfo.albumArtwork == null
                    ? AssetImage('assets/music_background.jpg')
                    : FileImage(File(widget.songInfo.albumArtwork)),
                radius: 75,
              ),
              Container(
                child: Text(
                  widget.songInfo.title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                child: Text(
                  widget.songInfo.artist,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Slider(
                inactiveColor: Colors.lightBlue[300],
                activeColor: Colors.lightBlue[800],
                min: minimumValue,
                max: maximumValue,
                value: currentValue,
                onChanged: (value) {
                  currentValue = value;
                  player.seek(Duration(milliseconds: currentValue.round()));
                },
              ),
              Container(
                transform: Matrix4.translationValues(0, -15, 0),
                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(currentTime,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500)),
                    Text(endTime,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 25, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: Icon(Icons.skip_previous,
                          color: Colors.lightBlue[600], size: 55),
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        widget.changeTrack(false);
                      },
                    ),
                    GestureDetector(
                      child: Icon(
                          isPlaying
                              ? Icons.pause_circle_filled_rounded
                              : Icons.play_circle_fill_rounded,
                          color: Colors.lightBlue[600],
                          size: 65),
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        changeStatus();
                      },
                    ),
                    GestureDetector(
                      child: Icon(Icons.skip_next,
                          color: Colors.lightBlue[600], size: 55),
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        widget.changeTrack(true);
                      },
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}