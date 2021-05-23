import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/controller/bmi/bmi_controller.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/image_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_section.dart';
import 'package:flutter_dog_adviser/models/bmi/bmi.dart';
import 'package:flutter_dog_adviser/models/dog/dog.dart';

class BMIDetails extends StatefulWidget {
  final Dog dogItem;
  final String dogGender;
  final double dogBMI;

  // final BMI data;
  BMIDetails({Key key, this.dogItem, this.dogBMI, this.dogGender})
      : super(key: key);

  _BMIDetailsState createState() => _BMIDetailsState();
}

class _BMIDetailsState extends State<BMIDetails>{
  List<BMI> _dogBMI = [];
  int underWeight;
  int overWeight;
  String status = "Your dog is Normal Weight";
  BMIController _ibmController = BMIController();

  @override
  void initState() {
    super.initState();
    _findDogBMI(widget.dogItem, widget.dogGender);
  }

  _findDogBMI(Dog dog, String gender) async {
    final dogBMI = await _ibmController.findDogBMI(dog.dogName, gender);
    setState(() {
      _dogBMI = dogBMI;
      underWeight = _dogBMI[0].underWeight;
      overWeight = _dogBMI[0].overWeight;
      if (widget.dogBMI<underWeight)
        status = "Your dog is Underweight !";
      if (widget.dogBMI>overWeight)
        status = "Your dog is OverWeight !";
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBarSection("Dog IBM Details"),

        drawer: SafeArea(
          child: DrawerSection(),
        ),

        body: SingleChildScrollView (
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ImageSection(widget.dogItem.dogImage),
              TextSection(
                widget.dogItem.dogName,
                "Dog's gender: "+widget.dogGender,
                "Your dog BMI: "+ widget.dogBMI.toString(),
                (
                    "\n\nOverweight : BMI > "+overWeight.toString()+"\n"+
                        "Normal weight: "+underWeight.toString()+" < BMI <"+overWeight.toString()+"\n"+
                    "Underweight: BMI < "+underWeight.toString()+"\n"
                ),
                status
              ),
            ],
          ),
        )
    );
  }
}