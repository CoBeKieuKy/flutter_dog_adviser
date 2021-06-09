import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dog_adviser/controller/profile/profile_controller.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/image_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_title.dart';
import 'package:flutter_dog_adviser/models/user_dog/user_dog.dart';
import 'package:flutter_dog_adviser/views/user_dog_details.dart';

class UserDogUpdate extends StatefulWidget{
  final UserDog userDog;
  UserDogUpdate({Key key, this.userDog}) : super(key: key);
  _UserDogUpdateState createState() => _UserDogUpdateState();
}

enum Activity { moderate_active, active, highly_active, weight_loss, senior }

class _UserDogUpdateState extends State<UserDogUpdate>{

  ProfileController _profileController = ProfileController();
  Activity _character = Activity.moderate_active;
  double multi = 1.6;
  double weight, height;
  String image_path = "assets/images/util/dog_icon.png";

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBarSection("Dog Info Input"),

      drawer: SafeArea(
        child: DrawerSection(),
      ),
      body:SingleChildScrollView(
        child:Container(
          child: Center(
            child:Padding(
              padding: EdgeInsets.all(25.0),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Card(
                    color: Colors.white70,
                    child: Column(
                      children: [
                        ImageSection(image_path),
                        TextSubtitle("Input your dog's basic stats"),
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: TextTitle("Choose your dog activity rate"),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ListTile(
                          title: TextSubtitle('Moderate Active Dog'),
                          leading: Radio<Activity>(
                            value: Activity.moderate_active,
                            groupValue: _character,
                            onChanged: (Activity value) {
                              setState(() {
                                _character = value;
                                multi = 1.7;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: TextSubtitle('Active Dog'),
                          leading: Radio<Activity>(
                            value: Activity.active,
                            groupValue: _character,
                            onChanged: (Activity value) {
                              setState(() {
                                _character = value;
                                multi = 2.0;
                              });
                            },
                          ),
                        ),ListTile(
                          title: TextSubtitle('Highly Active Dog'),
                          leading: Radio<Activity>(
                            value: Activity.highly_active,
                            groupValue: _character,
                            onChanged: (Activity value) {
                              setState(() {
                                _character = value;
                                multi = 3.0;
                              });
                            },
                          ),
                        ),ListTile(
                          title: TextSubtitle('Weight Loss'),
                          leading: Radio<Activity>(
                            value: Activity.weight_loss,
                            groupValue: _character,
                            onChanged: (Activity value) {
                              setState(() {
                                _character = value;
                                multi = 1.0;
                              });
                            },
                          ),
                        ),ListTile(
                          title: TextSubtitle('Senior'),
                          leading: Radio<Activity>(
                            value: Activity.senior,
                            groupValue: _character,
                            onChanged: (Activity value) {
                              setState(() {
                                _character = value;
                                multi = 1.1;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top:20.0,
                              bottom: 20.0
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty || double.parse(value) == 0) {
                                return 'Please enter weight';
                              }
                              setState(() {
                                weight = double.parse(value);
                              });
                              return null;
                            },
                            initialValue: '0',
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Dog's Weight (kg)",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.0,
                            bottom: 20,
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty || double.parse(value) == 0) {
                                return 'Please enter height';
                              }
                              setState(() {
                                height = double.parse(value);
                              });
                              return null;
                            },
                            initialValue: '0',
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Dog's Height (cm)",
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    double dogBMI = (weight / pow(height/100,2)).roundToDouble();
                                    double dogDER = (70 * pow(weight, 0.75)*multi).roundToDouble();

                                    await _profileController.insertProfile(
                                        widget.userDog.userDogId,
                                        height,
                                        weight,
                                        dogBMI, dogDER, DateTime.now().millisecondsSinceEpoch);
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => UserDogDetails(dogItem: widget.userDog,)
                                    )
                                    ).then((value) => setState(() => {}));
                                  }
                                },
                                child: TextSubtitle('Create New Dog Profile'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}