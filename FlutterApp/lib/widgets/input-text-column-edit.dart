import 'package:multimedia_app/screens/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputTextEditProfile extends StatelessWidget {
  TextEditingController controllers = TextEditingController();
  final String hintTitle;
  final maxLines;
  final double bottomValue;
  final IconData iconC;
  final TextInputType ktype;

  InputTextEditProfile({Key key, this.controllers, this.hintTitle, this.maxLines, this.bottomValue, this.iconC, this.ktype}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: TextFormField(
        controller: controllers,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: hintTitle,
            border: OutlineInputBorder(),
            prefixIcon: Padding(
              padding: bottomValue == 0.0 ? EdgeInsets.all(0.0) : EdgeInsets.fromLTRB(0, 0, 0, bottomValue),
              child: Icon(
                  iconC
              ),
            )
        ),
        maxLines: maxLines == 0 ? 1 : maxLines,
        keyboardType: ktype,
      ),
    );
  }
}