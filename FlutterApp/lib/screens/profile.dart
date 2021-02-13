import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:image_picker/image_picker.dart';

class InitScreen extends StatefulWidget {
  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(410, 730),
      allowFontScaling: false,
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter_ScreenUtil',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Profile(),
      ),
    );
  }
}

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  PickedFile _imageFile;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.lightBlue, Colors.indigoAccent],
                )
              ),
              width: ScreenUtil().setWidth(410),
              height: ScreenUtil().setHeight(730/3),
              child: Stack(
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundImage: _imageFile==null ? AssetImage("assets/profile_picture.jpg") : FileImage(File(_imageFile.path)),
                      //backgroundImage: AssetImage("assets/profile_picture.jpg"),
                      radius: 80.0
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: ((builder) => bottomSheet())
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text(
                        'Your Bio :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam vitae nibh eu mi scelerisque pharetra. Integer eget dolor mauris. Proin sit amet nulla lectus. Aenean ut velit ornare, condimentum magna eget, porta est. Integer rutrum laoreet laoreet. Vivamus id viverra ipsum. Sed mollis enim euismod nunc ultrices, et rutrum orci rutrum. Cras bibendum accumsan eleifend.',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    ListTile(
                        leading: Icon(Icons.assignment_ind),
                        title: Text(
                          'Your age :',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ),
                        ),
                        subtitle: Text('Im 21 years old')
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
                        subtitle: Text('Im living in Lyon, Rhônes-Alpes')
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
                        subtitle: Text('Im from France')
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.chat),
                      title: Text(
                        'Facebook :',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent
                        ),
                      ),
                      subtitle: Text('https://facebook.com/marianbret')
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
                        subtitle: Text('Followers : 150 000 Follows: 1500')
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
                        subtitle: Text('Followers : 35 000 Follows: 2500')
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget bottomSheet() {
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
                  onPressed: () {
                    takePicture(ImageSource.camera);
                  },
                  icon: Icon(
                      Icons.camera
                  ),
                  label: Text('camera')
              ),
              TextButton.icon(
                  onPressed: () {
                    takePicture(ImageSource.gallery);
                  },
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

  void takePicture(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }
}

/*Widget bottomSheet() {
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
                onPressed: () {},
                icon: Icon(
                  Icons.camera
                ),
                label: Text('camera')
            ),
            TextButton.icon(
              onPressed: () {
              },
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
*/