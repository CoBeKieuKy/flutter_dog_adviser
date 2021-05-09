import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/image_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_section.dart';
import 'package:flutter_dog_adviser/models/dog/dog.dart';

class DogDetails extends StatelessWidget{
  final Dog dog_item;
  DogDetails({Key key, this.dog_item}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBarSection(),

      drawer: SafeArea(
        child: DrawerSection(),
      ),

      body: SingleChildScrollView (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageSection(dog_item.dogImage),
            TextSection(dog_item.dogName,dog_item.dogNation, dog_item.dogTags, dog_item.dogInfo,dog_item.dogStatistics),
          ],
        ),
      )
    );
  }
}