import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class simpleTile extends StatelessWidget {

  final String bio;

  const simpleTile({Key key, this.bio}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.account_circle),
      title: Text(
        'Your Bio :',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent
        ),
      ),
      subtitle: Text(
        bio == null ? 'please enter a new bio' : bio,
        style: TextStyle(fontWeight: FontWeight.normal),
      ),
    );
  }
}