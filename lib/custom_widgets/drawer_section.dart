import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/screens/dog_classification.dart';
import 'package:flutter_dog_adviser/screens/dog_list.dart';

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
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
          ),

          ListTile(
            title: Text('Dog List'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DogList()));
            },
          ),

          ListTile(
            title: Text('Classify your dog'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DogClassification()));
            },
          ),
        ],
      ),
    );
  }
}
