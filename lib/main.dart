import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

void main() => runApp(MaterialApp(
  home: HomeScreen(),
));

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File pickedImage;
  bool isImageLoaded = false;
  String _confidence = "";
  List _result;
  String _name = "";
  String numbers = '';

  getImageFromGallery() async {
    var tempStore = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = File(tempStore.path);
      isImageLoaded = true;
      applyModelOnImage(File(tempStore.path));
    });
  }

  loadModel() async {
    var resultant = await Tflite.loadModel(
      labels: "assets/labels.txt",
      model: "assets/graph.lite",
    );
    print("Result $resultant");
  }

  applyModelOnImage(File file) async {
    var res = await Tflite.runModelOnImage(path: file.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _result = res;
      String str = _result[0]['label'];
      _name = str;
      _confidence =
      _result != null ? (_result[0]['confidence'] * 100.0).toString() + "%" : "";
    });
  }

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 30),
            isImageLoaded
                ? Center(
                child: Container(
                  height: 350,
                  width: 350,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(File(pickedImage.path)),
                          fit: BoxFit.contain)),
                )
            )
                : Container(),
            Text("Name: $_name \n Confidence: $_confidence")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImageFromGallery();
        },
        child: Icon(Icons.photo_album),
      ),
    );
  }
}
