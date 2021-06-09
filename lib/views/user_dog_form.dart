import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dog_adviser/controller/dog/dog_controller.dart';
import 'package:flutter_dog_adviser/controller/profile/profile_controller.dart';
import 'package:flutter_dog_adviser/controller/user_dog/user_dog_controller.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/image_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle.dart';
import 'package:flutter_dog_adviser/models/dog/dog.dart';
import 'package:flutter_dog_adviser/views/user_dog_list.dart';

class UserDogForm extends StatefulWidget{
  _UserDogFormState createState() => _UserDogFormState();
}

enum Gender { male, female }

class _UserDogFormState extends State<UserDogForm>{

  List<Dog> _dogs = [];
  DogController _dogListController = DogController();
  UserDogController _userDogController = UserDogController();
  ProfileController _profileController = ProfileController();
  List<DropdownMenuItem<Dog>> _dropdownMenuItems;
  Dog _selectedDog;
  Gender _character = Gender.male;
  String name ;
  double weight, height;
  String image_path = "assets/images/util/dog_icon.png";
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
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
                      DropdownButton(
                        value: _selectedDog,
                        items: _dropdownMenuItems,
                        onChanged: onChangeDropdownItem,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ListTile(
                        title: TextSubtitle('Male'),
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
                      title: TextSubtitle('Female'),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your dog\'s name';
                          }
                          setState(() {
                            name = value;
                          });
                          return null;
                        },
                        initialValue: 'My dog',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Dog's name",
                        ),
                      ),
                    ),
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
                                double dogDER = (119 * pow(weight,0.75)).roundToDouble();
                                int dogId = await _userDogController.insertUserDog(
                                  name, _selectedDog.dogName, _character.toString().split('.').last,_selectedDog.dogImage);
                                await _profileController.insertProfile(dogId, height, weight, dogBMI, dogDER, DateTime.now().millisecondsSinceEpoch);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UserDogList()
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