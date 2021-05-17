import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_title.dart';
import 'package:flutter_dog_adviser/screens/dog_classification.dart';
import 'package:flutter_dog_adviser/screens/dog_list.dart';
import 'package:flutter_dog_adviser/screens/food_list.dart';
import 'package:flutter_dog_adviser/screens/notify_list.dart';
import 'package:flutter_dog_adviser/screens/schedule_test.dart';

class DrawerSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 80.0,
            child: DrawerHeader(
              child: TextTitle('Dog Adviser'),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
          ),

          ListTile(
            title: TextSubtitle('Classify Your Dog'),
            leading: Icon(
              Icons.image_search,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DogClassification()));
            },
          ),

          ListTile(
            title: TextSubtitle('Dog List'),
            leading: Icon(
              Icons.book,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DogList()));
            },
          ),

          ListTile(
            title: TextSubtitle('Dog Food List'),
            leading: Icon(
              Icons.set_meal,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FoodList()));
            },
          ),
          ListTile(
            title: TextSubtitle('Check up your dog'),
            leading: Icon(
              Icons.contacts,
            ),
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => FoodList()));
            },
          ),
          ListTile(
            title: TextSubtitle('Schedule plan'),
            leading: Icon(
              Icons.schedule,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NotifyList()));
            },
          ),
        ],
      ),
    );
  }
}
