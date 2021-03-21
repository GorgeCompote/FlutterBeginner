import 'package:FlutterApp/models/data-store-classes-profile.dart';
import 'package:FlutterApp/widgets/dropdownbutton-country-profile.dart';
import 'package:FlutterApp/widgets/input-text-column-edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:localstorage/localstorage.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _bioController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _townController = TextEditingController();
  var _country = '';
  TextEditingController _facebookUrlController = TextEditingController();
  TextEditingController _instaUrlController = TextEditingController();
  TextEditingController _twitterUrlController = TextEditingController();
  final LocalStorage storage = new LocalStorage('localStorage_app');
  final datas = new StoreData();
  var countries = new CountryList().countriesList;
  var currentItemSelected = 'Change your country';

  refresh(var country) {
    setState(() {
      _country = country;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit profile page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputTextEditProfile(controllers: _bioController, hintTitle: 'change your bio', maxLines: 8, bottomValue: 135.0, iconC: Icons.account_circle),
            InputTextEditProfile(controllers: _ageController, hintTitle: 'Change your age', maxLines: 1, bottomValue: 0.0, iconC: Icons.assignment_ind, ktype: TextInputType.number),
            InputTextEditProfile(controllers: _townController, hintTitle: 'change your location', maxLines: 1, bottomValue: 0.0, iconC: Icons.add_location_alt_rounded),
            dropDownButtonCountry(countries: countries,  currentItemSelected: 'Change your country', country: '', countryCallback: refresh),
            InputTextEditProfile(controllers: _facebookUrlController, hintTitle: 'Change your Facebook info', maxLines: 1, bottomValue: 0.0, iconC: Icons.chat, ktype: TextInputType.url),
            InputTextEditProfile(controllers: _instaUrlController, hintTitle: 'Change your Instagram info', maxLines: 1, bottomValue: 0.0, iconC: Icons.favorite, ktype: TextInputType.url),
            InputTextEditProfile(controllers: _twitterUrlController, hintTitle: 'Change your Twitter info', maxLines: 1, bottomValue: 0.0, iconC: Icons.contactless_rounded, ktype: TextInputType.url),
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