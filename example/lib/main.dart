import 'package:flutter/material.dart';
import 'package:pinch_zoom_image/pinch_zoom_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Pinch Zoom Image',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pinch Zoom Image'),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              child: PinchZoomImage(
                image: Image.asset('images/camel.jpg'),
                zoomedBackgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: PinchZoomImage(
                image: Image(
                  image: CachedNetworkImageProvider(
                      'https://i.imgur.com/tKg0XEb.jpg'),
                ),
                zoomedBackgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
