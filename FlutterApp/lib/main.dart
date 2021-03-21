import 'package:flutter/material.dart';
import 'package:multimedia_app/widgets/nav-drawer.dart';

void main()  {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Multimedia App'),
      ),
      body: Center(
        child: Text('Welcome to your multimedia application.\nChoose between profile, gallery and music player on the left menu.\nEnjoy!',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black.withOpacity(0.6),
        height: 2, fontSize: 20),),
      ),
    );
  }
}