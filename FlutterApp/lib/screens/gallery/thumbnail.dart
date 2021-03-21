import 'package:flutter/material.dart';
import 'dart:async';
import 'package:photo_manager/photo_manager.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:FlutterApp/widgets/gallery/imageScreenWidget.dart';
import 'package:FlutterApp/widgets/gallery/ThumbnailWidget.dart';

class AssetThumbnail extends StatelessWidget {
  const AssetThumbnail({
    Key key,
    @required this.asset,
  }) : super(key: key);

  final AssetEntity asset;

  Widget build(BuildContext context) {
    return AssetThumbnailWidget(asset: asset);
  }
  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder<Uint8List>(
  //     future: asset.thumbData,
  //     builder: (_, snapshot) {
  //       final bytes = snapshot.data;
  //       if (bytes == null) return CircularProgressIndicator();
  //       return InkWell(
  //         onTap: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (_) {
  //                 if (asset.type == AssetType.image) {
  //                   return ImageScreen(imageFile: asset.file);
  //                 } else {
  //                   return VideoScreen(videoFile: asset.file);
  //                 }
  //               },
  //             ),
  //           );
  //         },
  //         child: Stack(
  //           children: [
  //             Positioned.fill(
  //               child: Image.memory(bytes, fit: BoxFit.cover),
  //             ),
  //             if (asset.type == AssetType.video)
  //               Center(
  //                 child: Container(
  //                   color: Colors.blue,
  //                   child: Icon(
  //                     Icons.play_arrow,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
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

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     color: Colors.black,
  //     alignment: Alignment.center,
  //     child: FutureBuilder<File>(
  //       future: imageFile,
  //       builder: (_, snapshot) {
  //         final file = snapshot.data;
  //         if (file == null) return Container();
  //         return Image.file(file);
  //       },
  //     ),
  //   );
  // }
}
