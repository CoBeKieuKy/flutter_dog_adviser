import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/controller/bmi/bmi_controller.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/image_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_foot.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle2.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_title.dart';
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
      appBar: AppBarSection("Dog BMI Details"),

      drawer: SafeArea(
        child: DrawerSection(),
      ),

      body: SingleChildScrollView (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          ImageSection(widget.dogItem.dogImage),
          Card(
            child: Column(
              children: [
                TextTitle(widget.dogItem.dogName),
                TextSubtitle('Gender: '+widget.dogGender),
                TextSubtitle2('Your dog\'s BMI: '+widget.dogBMI.toString()),
              ],
            ),
            color: Colors.white70,

          ),
          SizedBox(
            height: 10.0,
          ),
          TextSubtitle2("*according to American Kennel Club\'s BMI standard"),
          SizedBox(
            height: 10.0,
          ),
          Table(
            // defaultColumnWidth: FixedColumnWidth(120.0),
            border: TableBorder.all(
                color: Colors.black,
                style: BorderStyle.solid,
                width: 2),
            children: [
            TableRow(
              children: [
                Column(children:[TextSubtitle('Status')]),
                Column(children:[TextSubtitle('Dog\'s BMI')]),
              ]
            ),
              TableRow(
                  children: [
                    Column(children:[TextSubtitle('Underweight')]),
                    Column(children:[TextSubtitle(' < '+underWeight.toString())]),
                  ]
              ),
              TableRow(
                  children: [
                    Column(children:[TextSubtitle('Normal')]),
                    Column(children:[TextSubtitle(underWeight.toString()+" < < "+overWeight.toString())]),
                  ]
              ),
              TableRow(
                  children: [
                    Column(children:[TextSubtitle('Overweight')]),
                    Column(children:[TextSubtitle(' > '+overWeight.toString())]),
                  ]
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                TextSubtitle("Stats:"),
                TextFoot(status),
              ],
            ),
            color: Colors.white70,
          ),
        ],
        ),
      )
    );
  }
}