import 'package:flutter/material.dart';
import 'package:camera_deep_ar/camera_deep_ar.dart';

void main() {
  runApp(MyApp());
}

const apiKey =
    '5d838d8d081fe6b423166faf786d0b74778c15125861b33451b29f5ca1c177297402d634fe99622e';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late CameraDeepArController cameraDeepArController;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Face-Filters',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            CameraDeepAr(
                onCameraReady: (isReady) {
                  setState(() {});
                },
                onImageCaptured: (path) {
                  setState(() {});
                },
                onVideoRecorded: (path) {
                  setState(() {});
                },
                androidLicenceKey: apiKey,
                iosLicenceKey: apiKey,
                cameraDeepArCallback: (c) async {
                  cameraDeepArController = c;
                  setState(() {});
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(20),
                child: FloatingActionButton(
                    onPressed: () {
                      cameraDeepArController.changeMask(count);
                      count == 7 ? count = 0 : count++;
                    },
                  child: Icon(Icons.navigate_next,color: Colors.yellow,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}