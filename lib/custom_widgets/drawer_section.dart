import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_title.dart';
import 'package:flutter_dog_adviser/views/dog_classification.dart';
import 'package:flutter_dog_adviser/views/dog_list.dart';
import 'package:flutter_dog_adviser/views/food_list.dart';
import 'package:flutter_dog_adviser/views/notify_list.dart';
import 'package:flutter_dog_adviser/views/train_list.dart';
import 'package:flutter_dog_adviser/views/user_dog_list.dart';

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
              child: Row(
                children :[
                  Image.asset("assets/images/util/dog_icon.png"),
                  TextTitle('Dog Adviser'),
                ],
              ),
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
            title: TextSubtitle('User Dogs Profile'),
            leading: Icon(
              Icons.check_box,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserDogList()));
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
            title: TextSubtitle('Dog Training'),
            leading: Icon(
              Icons.pets,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TrainList()));
            },
          ),
          ListTile(
            title: TextSubtitle('Schedule Training'),
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
