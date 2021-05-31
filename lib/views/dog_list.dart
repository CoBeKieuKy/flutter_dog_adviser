import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/controller/dog/dog_controller.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle2.dart';
import 'package:flutter_dog_adviser/models/dog/dog.dart';

import 'dog_details.dart';

class DogList extends StatefulWidget {
  _DogListState createState() => _DogListState();
}

class _DogListState extends State<DogList>{
  List<Dog> _dogs = [];
  DogController _dogListController = DogController();

  @override
  void initState() {
    super.initState();
    _loadDogs();
  }

  _loadDogs() async {
    final dogs = await _dogListController.loadDogs();
    setState(() => _dogs = dogs);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBarSection("Dog List"),

      drawer: SafeArea(
        child: DrawerSection(),
      ),
      body:  ListView.builder(
        itemCount: _dogs.length,
        itemBuilder: (context, index) {
          final dog = _dogs[index];
          return
            Card(
                child: ListTile(
                  title: TextSubtitle(dog.dogName),
                  subtitle: TextSubtitle2(dog.dogTags),
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 80,
                      minHeight: 80,
                      maxWidth: 80,
                      maxHeight: 80,
                    ),
                    child: Image.asset(dog.dogImage, fit: BoxFit.cover),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DogDetails(dogItem: dog,))
                    );
                  },
                ),
            );
          }
      ),
    );
  }
}