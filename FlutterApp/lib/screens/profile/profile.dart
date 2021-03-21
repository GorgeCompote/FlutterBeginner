import 'dart:io';
import 'package:multimedia_app/main.dart';
import 'package:multimedia_app/widgets/bottom-sheet-camera.dart';
import 'package:multimedia_app/widgets/list-tiles/simple-listTile-profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:multimedia_app/widgets/list-tiles/list-tiles-profile.dart';
import 'package:multimedia_app/widgets/list-tiles/list-tiles-socialNetworks.dart';
import 'edit-profile.dart';

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
  @override
  void initState() {
    super.initState();
  }
  PickedFile _imageFile;
  var imageUrl = '';
  var _bio = '';
  var _age = '';
  var _town = '';
  var _country = '';
  var _facebookUrl = '';
  var _instaUrl = '';
  var _twitterUrl = '';

  final ImagePicker _picker = ImagePicker();
  final LocalStorage storage = new LocalStorage('localStorage_app');
  bool initialized = false;



  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile page'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
          },
        ),
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
              width: MediaQuery.of(context).size.width,
              height: ScreenUtil().setHeight(730/3),
              child: Stack(
                children: [
                  Center(
                    child: FutureBuilder(
                      future: storage.ready,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (!initialized) {
                          imageUrl = storage.getItem('profilePic_url');
                          _bio = storage.getItem('bio');
                          _age = storage.getItem('age');
                          _town = storage.getItem('town');
                          _country = storage.getItem('country');
                          _facebookUrl = storage.getItem('facebookUrl');
                          _instaUrl = storage.getItem('instaUrl');
                          _twitterUrl = storage.getItem('twitterUrl');
                          initialized = true;
                        }
                        return CircleAvatar(
                            backgroundImage: imageUrl == null ? AssetImage("assets/profile_picture.jpg") : FileImage(File(imageUrl)),
                            radius: 100.0
                        );
                      },
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
                            builder: ((builder) => bottomSheetProfile(callbackCam: () => takePicture(ImageSource.camera), callbackGal: () => takePicture(ImageSource.gallery)))
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
                        onPressed: () async {
                          final result = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditProfile())
                          );
                          setState(() {
                            _bio = result.biography == null ? _bio : result.biography;
                            _age = result.age == null ? _age : result.age;
                            _town = result.town == null ? _town : result.town;
                            _country = result.country == null ? _country : result.country;
                            _facebookUrl = result.facebookUrl == null ? _facebookUrl : result.facebookUrl;
                            _instaUrl = result.instaUrl == null ? _instaUrl : result.instaUrl;
                            _twitterUrl = result.twitterUrl == null ? _twitterUrl : result.twitterUrl;
                          });
                        },
                      ),
                    ),
                    FutureBuilder(
                      future: storage.ready,
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          return simpleTile(bio: _bio);
                        }
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Card(
                child: FutureBuilder(
                  future: storage.ready,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return ProfileTiles(age: _age, town: _town, country: _country);
                  },
                ),
              ),
            ),
            Center(
              child: Card(
                child: FutureBuilder(
                  future: storage.ready,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return SocialNetworksTiles(facebookUrl: _facebookUrl, instaUrl: _instaUrl, twitterUrl: _twitterUrl);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void takePicture(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    storage.setItem('profilePic_url', pickedFile.path);
    setState(() {
      _imageFile = pickedFile;
      imageUrl = pickedFile.path;
    });
  }
}