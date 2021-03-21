import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class ImageScreenWidget extends StatelessWidget {
  final Future<File> imageFile;
  ImageScreenWidget({Key key, this.imageFile}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: FutureBuilder<File>(
        future: imageFile,
        builder: (_, snapshot) {
          final file = snapshot.data;
          if (file == null) return Container();
          return Image.file(file);
        },
      ),
    );
  }
}
