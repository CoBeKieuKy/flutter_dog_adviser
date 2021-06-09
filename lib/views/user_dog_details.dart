import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/controller/bmi/bmi_controller.dart';
import 'package:flutter_dog_adviser/controller/profile/profile_controller.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/avg_data.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/image_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/main_data.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle2.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_title.dart';
import 'package:flutter_dog_adviser/models/bmi/bmi.dart';
import 'package:flutter_dog_adviser/models/profile/profile.dart';
import 'package:flutter_dog_adviser/models/user_dog/user_dog.dart';
import 'package:flutter_dog_adviser/views/user_dog_update.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDogDetails extends StatefulWidget {
  final UserDog dogItem;

  // final BMI data;
  UserDogDetails({Key key, this.dogItem,})
      : super(key: key);

  _UserDogDetailsState createState() => _UserDogDetailsState();
}

class _UserDogDetailsState extends State<UserDogDetails>{
  List<BMI> _dogBMI = [];
  List<Profile> _dogProfiles = [];
  int underWeight;
  int overWeight;
  double currentBmi;
  double currentDer;
  List<double> height = [];
  List<double> weight = [];
  bool showAvg = false;
  String status = "Your dog is Normal Weight";
  BMIController _ibmController = BMIController();
  ProfileController _profileController = ProfileController();

  @override
  void initState() {
    super.initState();
    _loadDogProfiles(widget.dogItem, widget.dogItem.userDogGender);
  }
  
  _loadDogProfiles(UserDog dog, String gender) async {
    final dogProfiles = await _profileController.loadProfiles(dog);
    final dogBMI = await _ibmController.findDogBMI(dog.userDogBreed, gender);
    setState(() {
      _dogBMI = dogBMI;
      _dogProfiles = dogProfiles;
      underWeight = _dogBMI[0].underWeight;
      overWeight = _dogBMI[0].overWeight;

      for(int i = 0; i<_dogProfiles.length; i++) {
        height.add(_dogProfiles[i].dogHeight / 10);
        weight.add(_dogProfiles[i].dogWeight / 10);
      }
      currentBmi = _dogProfiles[0].dogBMI;
      if (currentBmi<underWeight)
        status = "Your dog is Underweight !";
      else if (currentBmi>overWeight)
        status = "Your dog is OverWeight !";
      else
        status = "Your dog is Normal Weight";
      currentDer = _dogProfiles[0].dogDER;
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
          ImageSection(widget.dogItem.userDogImage),
          Card(
            child: Column(
              children: [
                TextTitle(widget.dogItem.userDogName),
                TextSubtitle2('Gender: '+widget.dogItem.userDogGender),
                TextSubtitle("Breed: "+widget.dogItem.userDogBreed),
            ],
            ),
            color: Colors.white70,

          ),
          Card(
            child:Column(
              children:[
                TextTitle("Your dog\'s current BMI"),
                Text(
                  currentBmi.toString(),
                  style: GoogleFonts.elMessiri(
                    textStyle: Theme.of(context).textTheme.headline5,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent,
                  ),
                ),
                TextSubtitle(status),
                TextSubtitle("Daily Energy Requirements"),
                Text(
                  currentDer.toString()+" kcal",
                  style: GoogleFonts.elMessiri(
                    textStyle: Theme.of(context).textTheme.headline5,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent,
                  ),
                ),
              ]
            ),
            color: Colors.green,
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
                    Column(children:[TextSubtitle('BMI < '+underWeight.toString())]),
                  ]
              ),
              TableRow(
                  children: [
                    Column(children:[TextSubtitle('Normal')]),
                    Column(children:[TextSubtitle(underWeight.toString()+" < BMI < "+overWeight.toString())]),
                  ]
              ),
              TableRow(
                  children: [
                    Column(children:[TextSubtitle('Overweight')]),
                    Column(children:[TextSubtitle('BMI > '+overWeight.toString())]),
                  ]
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Card(
            child: TextSubtitle("Dog\'s height data (dm / checkup time)"),
            color: Colors.green,
          ),
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.70,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color(0xff232d37)),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
                    child: LineChart(
                      showAvg ?
                      (height.length>6 ? AvgData(6, 11, height.sublist(0,6)).avgData() : AvgData(6, 11, height).avgData()) :
                      (height.length >6 ? MainData(height.sublist(0,6),11, 6).mainData() : MainData(height,11, 6).mainData()),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 60,
                height: 34,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      showAvg = !showAvg;
                    });
                  },
                  child: Text(
                    'Avg',
                    style: TextStyle(
                        fontSize: 12, color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
            Card(
              child: TextSubtitle("Dog\'s weight data (kg/10 / checkup time)"),
              color: Colors.green,
            ),
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.70,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color(0xff232d37)),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
                    child: LineChart(
                      showAvg ?
                      (height.length>6 ? AvgData(6, 11, weight.sublist(0,6)).avgData() : AvgData(6, 11, weight).avgData()) :
                      (height.length >6 ? MainData(weight.sublist(0,6),11, 6).mainData() : MainData(weight,11, 6).mainData()),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 60,
                height: 34,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      showAvg = !showAvg;
                    });
                  },
                  child: Text(
                    'Avg',
                    style: TextStyle(
                        fontSize: 12, color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
                  ),
                ),
              ),
            ],
          ),

            Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserDogUpdate(userDog: widget.dogItem)));
              },
              child: Text('Update your dog\'s info'),
            ),
          ),
          ],
        ),
        ],
        ),
      )
    );
  }
}