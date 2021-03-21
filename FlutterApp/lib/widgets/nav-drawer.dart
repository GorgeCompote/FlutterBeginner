import 'package:flutter/material.dart';
import 'package:multimedia_app/screens/profile/profile.dart';
import 'package:multimedia_app/screens/gallery/gallery.dart';
import 'package:multimedia_app/screens/musicplayer/musicplayer.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InitScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Gallery()));
              },
            ),
            ListTile(
              leading: Icon(Icons.border_color),
              title: Text('Music Player'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Musics()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
