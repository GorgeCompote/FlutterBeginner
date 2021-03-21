import 'package:flutter/material.dart';
import 'dart:async';
import 'package:photo_manager/photo_manager.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:multimedia_app/widgets/gallery/imageScreenWidget.dart';
import 'package:multimedia_app/widgets/gallery/ThumbnailWidget.dart';

class AssetThumbnail extends StatelessWidget {
  const AssetThumbnail({
    Key key,
    @required this.asset,
  }) : super(key: key);

  final AssetEntity asset;

  Widget build(BuildContext context) {
    return AssetThumbnailWidget(asset: asset);
  }
}

class ImageScreen extends StatelessWidget {
  const ImageScreen({
    Key key,
    @required this.imageFile,
  }) : super(key: key);

  final Future<File> imageFile;

  Widget build(BuildContext context) {
    return ImageScreenWidget(imageFile: imageFile);
  }
}
