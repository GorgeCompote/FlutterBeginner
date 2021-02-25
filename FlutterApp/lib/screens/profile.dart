import 'dart:io';

import 'package:FlutterApp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';

class StoreData {
  String biography;
  String age;
  String town;
  String country;
  String facebookUrl;
  String instaUrl;
  String twitterUrl;
}

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
                        onPressed: () async {
                          final result = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditProfile())
                          );
                          //print('result = \n');
                          //print(result.biography == null);
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
                              _bio == null ? 'please enter a new bio' : _bio,
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                          );
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
                            subtitle: Text(_age == null ? 'Enter your age' : _age)
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
                            subtitle: Text(_town == null ? 'Enter your living town' : _town)
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
                            subtitle: Text(_country == null ? 'Enter your country' : _country)
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            Center(
              child: Card(
                child: FutureBuilder(
                  future: storage.ready,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                            subtitle: Text(_facebookUrl == null ? 'Enter your Facebook url' : _facebookUrl)
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
                            subtitle: Text(_instaUrl == null ? 'Enter your insta url' : _instaUrl)
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
                            subtitle: Text(_twitterUrl == null ? 'Enter your twitter url' : _twitterUrl)
                        )
                      ],
                    );
                  },
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
    storage.setItem('profilePic_url', pickedFile.path);
    setState(() {
      _imageFile = pickedFile;
      imageUrl = pickedFile.path;
    });
  }
}

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _bioController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _townController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  var _country = '';
  TextEditingController _facebookUrlController = TextEditingController();
  TextEditingController _instaUrlController = TextEditingController();
  TextEditingController _twitterUrlController = TextEditingController();
  final LocalStorage storage = new LocalStorage('localStorage_app');
  final datas = new StoreData();
  var countries = ["Change your country","United States", "Canada", "Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla", "Antarctica", "Antigua and/or Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana", "Bouvet Island", "Brazil", "British Indian Ocean Territory", "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile", "China", "Christmas Island", "Cocos (Keeling) Islands", "Colombia", "Comoros", "Congo", "Cook Islands", "Costa Rica", "Croatia (Hrvatska)", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "East Timor", "Ecudaor", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Falkland Islands (Malvinas)", "Faroe Islands", "Fiji", "Finland", "France", "France, Metropolitan", "French Guiana", "French Polynesia", "French Southern Territories", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Heard and Mc Donald Islands", "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran (Islamic Republic of)", "Iraq", "Ireland", "Israel", "Italy", "Ivory Coast", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea, Democratic People's Republic of", "Korea, Republic of", "Kosovo", "Kuwait", "Kyrgyzstan", "Lao People's Democratic Republic", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libyan Arab Jamahiriya", "Liechtenstein", "Lithuania", "Luxembourg", "Macau", "Macedonia", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Martinique", "Mauritania", "Mauritius", "Mayotte", "Mexico", "Micronesia, Federated States of", "Moldova, Republic of", "Monaco", "Mongolia", "Montserrat", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Niue", "Norfork Island", "Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Pitcairn", "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", "Russian Federation", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Georgia South Sandwich Islands", "South Sudan", "Spain", "Sri Lanka", "St. Helena", "St. Pierre and Miquelon", "Sudan", "Suriname", "Svalbarn and Jan Mayen Islands", "Swaziland", "Sweden", "Switzerland", "Syrian Arab Republic", "Taiwan", "Tajikistan", "Tanzania, United Republic of", "Thailand", "Togo", "Tokelau", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks and Caicos Islands", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States minor outlying islands", "Uruguay", "Uzbekistan", "Vanuatu", "Vatican City State", "Venezuela", "Vietnam", "Virigan Islands (British)", "Virgin Islands (U.S.)", "Wallis and Futuna Islands", "Western Sahara", "Yemen", "Yugoslavia", "Zaire", "Zambia", "Zimbabwe"];
  var currentItemSelected = 'Change your country';

  @override
  Widget build(BuildContext context) {
    var coeffScreen = MediaQuery.of(context).size.width * 0.06;
    print(ScreenUtil().screenWidth);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit profile page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: TextFormField(
                controller: _bioController,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: 'Change your bio',
                  border: OutlineInputBorder(),
                  prefixIcon: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 135),
                    child: Icon(
                      Icons.account_circle
                    ),
                  )
                ),
                maxLines: 8,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Change your age',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.assignment_ind)
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: TextFormField(
                controller: _townController,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Change your location',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.add_location_alt_rounded)
                ),
                keyboardType: TextInputType.streetAddress,
              ),
            ),
            Padding(
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
                items: countries.map((String dropDownStringItem) {
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
                    this.currentItemSelected = newValueSelected;
                    _country = newValueSelected;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: TextFormField(
                controller: _facebookUrlController,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Change your Facebook info',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.chat)
                ),
                keyboardType: TextInputType.url,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: TextFormField(
                controller: _instaUrlController,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Change your Instagram info',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.favorite)
                ),
                keyboardType: TextInputType.url,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: TextFormField(
                controller: _twitterUrlController,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Change your Twitter info',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.contactless_rounded)
                ),
                keyboardType: TextInputType.url,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: SizedBox(
                    width: ScreenUtil().setWidth(100),
                    child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: SizedBox(
                    width: ScreenUtil().setWidth(100),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_bioController.text != null && _bioController.text != '') {
                            storage.setItem('bio', _bioController.text);
                            datas.biography = _bioController.text;
                          }
                          if (_ageController.text != null && _ageController.text != '') {
                            storage.setItem('age', _ageController.text);
                            datas.age = _ageController.text;
                          }
                          if (_townController.text != null && _townController.text != '') {
                            storage.setItem('town', _townController.text);
                            datas.town = _townController.text;
                          }
                          if (_country != null && _country != '') {
                            storage.setItem('country', _country);
                            datas.country = _country;
                          }
                          if (_facebookUrlController.text != null && _facebookUrlController.text != '') {
                            storage.setItem('facebookUrl', _facebookUrlController.text);
                            datas.facebookUrl = _facebookUrlController.text;
                          }
                          if (_instaUrlController.text != null && _instaUrlController.text != '') {
                            storage.setItem('instaUrl', _instaUrlController.text);
                            datas.instaUrl = _instaUrlController.text;
                          }
                          if (_twitterUrlController.text != null && _twitterUrlController.text != '') {
                            storage.setItem('twitterUrl', _twitterUrlController.text);
                            datas.twitterUrl = _twitterUrlController.text;
                          }
                          //print(datas);
                          Navigator.pop(context, datas);
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
