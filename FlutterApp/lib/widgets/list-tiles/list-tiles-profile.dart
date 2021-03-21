import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileTiles extends StatelessWidget {
  const ProfileTiles({Key key, this.age, this.town, this.country}) : super(key: key);

  final String age;
  final String town;
  final String country;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListTile(
            leading: Icon(Icons.assignment_ind),
            title: Text(
              'Your age :',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent
              ),
            ),
            subtitle: Text(age == null ? 'Enter your age' : age)
        ),
        ListTile(
            leading: Icon(Icons.add_location_alt_rounded),
            title: Text(
              'Your living town :',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent
              ),
            ),
            subtitle: Text(town == null ? 'Enter your living town' : town)
        ),
        ListTile(
            leading: Icon(Icons.airplanemode_active_rounded),
            title: Text(
              'Your country :',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent
              ),
            ),
            subtitle: Text(country == null ? 'Enter your country' : country)
        )
      ],
    );
  }
}