import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/image_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_body.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_title.dart';
import 'package:flutter_dog_adviser/models/train/train.dart';

class TrainDetails extends StatelessWidget{
  final Train trainItem;
  TrainDetails({Key key, this.trainItem}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBarSection("Training Details"),

        drawer: SafeArea(
          child: DrawerSection(),
        ),

        body: SingleChildScrollView (
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Column(
                  children: [
                    ImageSection(trainItem.trainImage),
                    TextTitle(trainItem.trainName),
                    TextSubtitle(trainItem.trainFor),
                  ],
                ),
                color: Colors.white70,
              ),
              TextBody(trainItem.trainInfo),
            ],
          ),
        )
    );
  }
}