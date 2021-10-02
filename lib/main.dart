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
  CameraDeepArController? cameraDeepArController;
  int currentPage = 0;
  final vp = PageController(viewportFraction: .24);
  Effects currentEffect = Effects.none;
  Filters currentFilter = Filters.none;
  Masks currentMask = Masks.none;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            CameraDeepAr(
                onCameraReady: (isReady) {
                  setState(() {});
                },
                onImageCaptured: (path) {
                  setState(() {});
                },
                onVideoRecorded: (path) {
                  isRecording = false;
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
                //height: 250,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              if (null == cameraDeepArController) return;
                              if (isRecording) return;
                              cameraDeepArController!.snapPhoto();
                            },
                            child: Icon(Icons.camera_enhance_outlined),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.all(15),),
                          ),
                        ),
                        if (isRecording)
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                if (null == cameraDeepArController) return;
                                cameraDeepArController!.stopVideoRecording();
                                isRecording = false;
                                setState(() {});
                              },
                              child: Icon(Icons.videocam_off),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: EdgeInsets.all(15),),
                            ),
                          )
                        else
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                if (null == cameraDeepArController) return;
                                cameraDeepArController!.startVideoRecording();
                                isRecording = true;
                                setState(() {});
                              },
                              child: Icon(Icons.videocam),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: EdgeInsets.all(15),),
                            ),
                          ),
                      ],
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.all(15),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(Masks.values.length, (p) {
                          bool active = currentPage == p;
                          return GestureDetector(
                            onTap: () {
                              currentPage = p;
                              cameraDeepArController!.changeMask(p);
                              setState(() {});
                            },
                            child: Container(
                                margin: EdgeInsets.all(5),
                                width: active ? 40 : 30,
                                height: active ? 50 : 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color:
                                    active ? Colors.orange : Colors.white,
                                    shape: BoxShape.circle),
                                child: Text(
                                  "$p",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: active ? 16 : 14,
                                      color: Colors.black),
                                )),
                          );
                        }),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}