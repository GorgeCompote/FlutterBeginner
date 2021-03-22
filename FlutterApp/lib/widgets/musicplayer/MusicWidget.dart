import 'package:multimedia_app/screens/musicplayer/track_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:multimedia_app/screens/musicplayer/musicplayer.dart';
import 'dart:io';
import '../../main.dart';


class MusicWidget extends StatefulWidget {
  List<SongInfo> songs;
  int currentIndex;
  final GlobalKey<TrackListenerState> keys;
  MusicWidget({Key key,this.songs, this.currentIndex, this.keys}):super(key: key);
  @override
  _MusicWidgetState createState() => _MusicWidgetState();
}

class _MusicWidgetState extends State<MusicWidget> {

  final VoidCallback changeTrack;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Music Player'),
          backgroundColor: Colors.lightBlue[600],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyHomePage()));
            },
          ),
        ),
        body: Container(
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: widget.songs.length,
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(
                backgroundImage: widget.songs[index].albumArtwork == null
                    ? AssetImage('assets/music_background.jpg')
                    : FileImage(File(widget.songs[index].albumArtwork)),
              ),
              title: Text(widget.songs[index].title),
              subtitle: Text(widget.songs[index].artist),
              onTap: () {
                widget.currentIndex = index;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TrackListener(changeTrack: changeTrack,
                          songInfo: widget.songs[widget.currentIndex],key:widget.keys
                        )));
              },
            ),
          ),
        ),
      );
    }
}