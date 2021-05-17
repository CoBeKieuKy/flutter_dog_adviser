import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/image_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/result_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_body.dart';
import 'package:flutter_dog_adviser/models/dog/dog.dart';
import 'package:flutter_dog_adviser/models/dog/dog_repository.dart';
import 'package:get_it/get_it.dart';

import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class DogClassification extends StatefulWidget {
  @override
  _DogClassificationState createState() => _DogClassificationState();
}

class _DogClassificationState extends State<DogClassification> {
  File pickedImage;
  bool isImageLoaded = false;
  String _confidence = "";
  List _result;
  String _name = "";
  double _percentageResult= 0.0;
  List<Dog> _foundDog;
  DogRepository _dogRepository = GetIt.I.get();



  getImageFromGallery() async {
    var tempStore = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = File(tempStore.path);
      isImageLoaded = true;
      applyModelOnImage(File(tempStore.path));
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      labels: "assets/tflite/labels.txt",
      model: "assets/tflite/graph.lite",
    );
  }

  applyModelOnImage(File file) async {
    var respond = await Tflite.runModelOnImage(path: file.path,
        numResults: 2,
        threshold: 0.1,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _result = respond;
      String str = _result[0]['label'];
      _percentageResult = (10000.0*_result[0]['confidence']).floor()/10000.0;
      _name = str;
      _confidence = _result != null ? (_percentageResult*100.0).toString() + "%" : "";
    });
    _findDog(_name);
  }

  _findDog(String dogName) async{
    final foundDog = await _dogRepository.findDog(dogName);
    setState(()=> _foundDog = foundDog);
  }

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSection("Dog Classification"),

      drawer: SafeArea(
        child: DrawerSection(),
      ),

      body: SingleChildScrollView (
      child: Container(
        child: Column(
          children: [
            Container(
              child: TextBody('Pick your dog image by floating button'),
              margin: EdgeInsets.fromLTRB(25, 25, 25, 0),
            ),

            isImageLoaded
            ? Center(
            child:
            Column(
              children: [
                Container(
                  height: 350.0,
                  width: 350.0,
                  decoration: BoxDecoration(
                      color: Colors.white10,

                      image: DecorationImage(

                        image: FileImage(File(pickedImage.path)),
                        fit: BoxFit.cover)),
                ),
                ResultSection(_name, _confidence, _foundDog, _percentageResult),
              ],
            )
          )
            : Center(
                child: ImageSection("assets/images/util/dog.gif"),
              ),
            ],
          ),
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