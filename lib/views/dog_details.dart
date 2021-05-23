import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/image_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_section.dart';
import 'package:flutter_dog_adviser/models/dog/dog.dart';

class DogDetails extends StatelessWidget{
  final Dog dogItem;
  DogDetails({Key key, this.dogItem}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBarSection("Dog Details"),

      drawer: SafeArea(
        child: DrawerSection(),
      ),

      body: SingleChildScrollView (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageSection(dogItem.dogImage),
            TextSection(dogItem.dogName,dogItem.dogNation, dogItem.dogTags, dogItem.dogInfo,dogItem.dogStatistics),
          ],
        ),
      )
    );
  }
}