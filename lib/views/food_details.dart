import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/image_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_section.dart';
import 'package:flutter_dog_adviser/models/food/food.dart';

class FoodDetails extends StatelessWidget{
  final Food foodItem;
  FoodDetails({Key key, this.foodItem}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBarSection("Food Details"),

        drawer: SafeArea(
          child: DrawerSection(),
        ),

        body: SingleChildScrollView (
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ImageSection(foodItem.foodImage),
              TextSection(foodItem.foodName,foodItem.foodType, foodItem.foodEdible, foodItem.foodInfo,foodItem.foodFor),
            ],
          ),
        )
    );
  }
}