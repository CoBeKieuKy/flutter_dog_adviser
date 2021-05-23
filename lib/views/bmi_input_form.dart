import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dog_adviser/controller/dog/dog_controller.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle.dart';
import 'package:flutter_dog_adviser/models/dog/dog.dart';

import 'bmi_details.dart';


class BMIInputForm extends StatefulWidget{
  _BMIInputFormState createState() => _BMIInputFormState();
}

enum Gender { male, female }

class _BMIInputFormState extends State<BMIInputForm>{

  List<Dog> _dogs = [];
  DogController _dogListController = DogController();
  List<DropdownMenuItem<Dog>> _dropdownMenuItems;
  Dog _selectedDog;
  Gender _character;
  double weight;
  double height ;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _character = Gender.male;
    _loadDogs();
  }

  _loadDogs() async {
    final dogs = await _dogListController.loadDogs();
    setState(() => _dogs = dogs);
    _dropdownMenuItems = buildDropdownMenuItems(_dogs);
    _selectedDog = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<Dog>> buildDropdownMenuItems(List dogs) {
    List<DropdownMenuItem<Dog>> items = List();
    for (Dog dog in dogs) {
      items.add(
        DropdownMenuItem(
          value: dog,
          child: Text(dog.dogName),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Dog selectedDog) {
    setState(() {
      _selectedDog = selectedDog;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBarSection("Dog IBM Input"),

      drawer: SafeArea(
        child: DrawerSection(),
      ),
      body:SingleChildScrollView(
        child:Container(
          child: Center(
            child:Card(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextSubtitle("Select a dog breed"),
                  SizedBox(
                    height: 20.0,
                  ),
                  DropdownButton(
                    value: _selectedDog,
                    items: _dropdownMenuItems,
                    onChanged: onChangeDropdownItem,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ListTile(
                    title: const Text('Male'),
                    leading: Radio<Gender>(
                      value: Gender.male,
                      groupValue: _character,
                      onChanged: (Gender value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Female'),
                    leading: Radio<Gender>(
                      value: Gender.female,
                      groupValue: _character,
                      onChanged: (Gender value) {
                        setState(() {
                          _character = value;
                        });
                      },
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
                                    final double dogBMI = ((10 * weight / pow(height/100,2)).ceil())/10;
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => BMIDetails(
                                          dogItem: _selectedDog,
                                          dogBMI: dogBMI,
                                          dogGender: _character.toString().split('.').last,
                                        )
                                      )
                                    );
                                  }
                                },
                                child: Text('Check Up !'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}