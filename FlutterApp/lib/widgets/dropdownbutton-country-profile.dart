import 'package:multimedia_app/models/data-store-classes-profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class dropDownButtonCountry extends StatefulWidget {
  final Function countryCallback;
  final List<String> countries;
  var currentItemSelected;
  var country;

  dropDownButtonCountry({Key key, this.countries, this.currentItemSelected, this.country, this.countryCallback}) : super(key: key);

  @override
  _dropDownButtonCountryState createState() => _dropDownButtonCountryState();
}

class _dropDownButtonCountryState extends State<dropDownButtonCountry> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: 'Change your country',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.airplanemode_active_rounded)
        ),
        icon: Icon(
            Icons.arrow_drop_down
        ),
        iconSize: 36.0,
        items: widget.countries.map((String dropDownStringItem) {
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: Text(
              dropDownStringItem,
              style: TextStyle(
                  color: Color(0xFF656565)
              ),
            ),
          );
        }).toList(),
        onChanged: (String newValueSelected) {
          setState(() {
            this.widget.currentItemSelected = newValueSelected;
            widget.countryCallback(newValueSelected);
          });
        },
      ),
    );
  }
}