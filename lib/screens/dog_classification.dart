import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_body.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle.dart';
import 'package:flutter_dog_adviser/models/dog/dog.dart';
import 'package:flutter_dog_adviser/models/dog/dog_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import 'dog_details.dart';


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
  String numbers = '';
  double _percentage_result= 0.0;
  List<Dog> _foundDog;
  DogRepository _dogRepository = GetIt.I.get();

  _findDog(String dogName) async{
    final foundDog = await _dogRepository.findDog(dogName);
    setState(()=> _foundDog = foundDog);
  }

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
      labels: "assets/tflite/labels.txt",
      model: "assets/tflite/graph.lite",
    );
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
      _percentage_result = (10000.0*_result[0]['confidence']).ceil()/10000.0;
      _name = str;
      _confidence = _result != null ? (_percentage_result*100.0).toString() + "%" : "";
    });
    _findDog(_name);
  }

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSection(),

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
                    image: DecorationImage(
                        image: FileImage(File(pickedImage.path)),
                        fit: BoxFit.contain)),
                ),
                Container(
                  padding: EdgeInsets.all(15.0),
                  child: new LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 30,
                    animation: true,
                    lineHeight: 40.0,
                    animationDuration: 2500,
                    percent: _percentage_result,
                    center: new Text("$_name : $_confidence"),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Colors.green,
                  ),
                ),

                FlatButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DogDetails(dog_item: _foundDog[0]))
                    );
                  },
                  child: TextSubtitle('$_name'),
                  color: Colors.yellowAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  height: 50,
                ),
              ],
            )
          )
            : Center(
                child: Container(
                  constraints: BoxConstraints.expand(
                      height: 350.0,
                      width: 350.0
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Image.asset("assets/images/dog.gif", fit: BoxFit.cover,),
                ),
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