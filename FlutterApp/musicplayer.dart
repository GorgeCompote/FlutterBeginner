import 'package:multimedia_app/widgets/musicplayer/MusicWidget.dart';
import 'package:multimedia_app/widgets/musicplayer/track_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'dart:io';

import '../../main.dart';

class Musics extends StatefulWidget {
  @override
  _MusicPlayer createState() => _MusicPlayer();
}

class _MusicPlayer extends State<Musics> {
  FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<SongInfo> songs = [];
  int currentIndex = 0;
  final GlobalKey<TrackListenerState> key=GlobalKey<TrackListenerState>();

  @override
  void initState() {
    super.initState();
    getTracks();
  }

  void getTracks() async {
    songs = await audioQuery.getSongs();
    setState(() {
      songs = songs;
    });
  }

void changeTrack(bool isNext) {
    if(isNext) {
      if(currentIndex!=songs.length-1) {
        currentIndex++;
      }

    } else {
      if(currentIndex!=0) {
        currentIndex--;
      }
    }
    key.currentState.setSong(songs[currentIndex]);
  }

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
          itemCount: songs.length,
          itemBuilder: (context, index) => ListTile(
            leading: CircleAvatar(
              backgroundImage: songs[index].albumArtwork == null
                  ? AssetImage('assets/music_background.jpg')
                  : FileImage(File(songs[index].albumArtwork)),
            ),
            title: Text(songs[index].title),
            subtitle: Text(songs[index].artist),
            onTap: () {
              currentIndex = index;
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TrackListener(changeTrack: changeTrack,
                        songInfo: songs[currentIndex],key:key
                      )));
            },
          ),
        ),
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return (MusicWidget(changeTrack: changeTrack,songs: songs));
  // }
}
