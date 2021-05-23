import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/database/init_database.dart';
import 'package:flutter_dog_adviser/views/dog_list.dart';

class App extends StatelessWidget{

  Widget build(BuildContext context){
    final Future _init =  InitDatabase.initialize();

    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: FutureBuilder(
        future: _init,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return DogList();
          } else {
            return Material(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
      ),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.green,
          )
        ),
    );
  }
}