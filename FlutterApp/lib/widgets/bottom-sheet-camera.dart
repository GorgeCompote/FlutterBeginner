import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class bottomSheetProfile extends StatelessWidget {

  final Function callbackCam;
  final Function callbackGal;

  const bottomSheetProfile({Key key, this.callbackCam, this.callbackGal}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: ScreenUtil().setWidth(410),
      child: Column(
        children: [
          Text(
            'Choose profile picture',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 12.0)
              ),
              TextButton.icon(
                  onPressed: () => callbackCam(),
                  icon: Icon(
                      Icons.camera
                  ),
                  label: Text('camera')
              ),
              TextButton.icon(
                  onPressed: () => callbackGal(),
                  icon: Icon(
                    Icons.camera,
                  ),
                  label: Text('gallery')
              ),
            ],
          )
        ],
      ),
    );
  }
}