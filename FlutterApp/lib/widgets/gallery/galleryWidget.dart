import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:FlutterApp/screens/gallery/thumbnail.dart';

class GalleryWidget extends StatefulWidget {
  List<AssetEntity> assets;
  GalleryWidget({Key key, this.assets}):super(key: key);
  @override
  _GalleryWidgetState createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends  State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: widget.assets.length,
        itemBuilder: (_, index) {
          return AssetThumbnail(asset: widget.assets[index]);
        },
      ),
    );
  }
}