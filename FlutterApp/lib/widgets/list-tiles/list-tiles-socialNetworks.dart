import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SocialNetworksTiles extends StatelessWidget {

  final String facebookUrl;
  final String instaUrl;
  final String twitterUrl;

  const SocialNetworksTiles({Key key, this.facebookUrl, this.instaUrl, this.twitterUrl}) : super(key: key);
  @override
  Widget build (BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListTile(
            leading: Icon(Icons.chat),
            title: Text(
              'Facebook :',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent
              ),
            ),
            subtitle: Text(facebookUrl == null ? 'Enter your Facebook url' : facebookUrl)
        ),
        ListTile(
            leading: Icon(Icons.favorite),
            title: Text(
              'Instagram :',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent
              ),
            ),
            subtitle: Text(instaUrl == null ? 'Enter your insta url' : instaUrl)
        ),
        ListTile(
            leading: Icon(Icons.contactless_rounded),
            title: Text(
              'Twitter :',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent
              ),
            ),
            subtitle: Text(twitterUrl == null ? 'Enter your twitter url' : twitterUrl)
        )
      ],
    );
  }
}