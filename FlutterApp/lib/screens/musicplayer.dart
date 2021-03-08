import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'dart:io';
import 'dart:async';

import '../main.dart';

class Musics extends StatefulWidget {
  @override
  _MusicPlayer createState() => _MusicPlayer();
}

class _MusicPlayer extends State<Musics> {
  FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<SongInfo> songs = [];

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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player'),
        backgroundColor: Colors.lightBlue[600],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
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
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
