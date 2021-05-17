import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/notification/local_notify_manager.dart';

class ScheduleTest extends StatefulWidget {
  @override
  _ScheduleTestState createState() => _ScheduleTestState();
}

class _ScheduleTestState extends State<ScheduleTest>{

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBarSection("Test"),

        drawer: SafeArea(
          child: DrawerSection(),
        ),

      body: Column(
        children: [
          FlatButton(
            onPressed: () async {
              await localNotifyManager.scheduleWeeklyNotification(0, 13, 7, 1);},
            child: Text("Khassar de Templari")
          ),
          FlatButton(
            onPressed: () async {
              await localNotifyManager.scheduleWeeklyNotification(1, 13, 7, 1);},
            child: Text("Khassar de Templari")
          ),
          FlatButton(
            onPressed: () async{
              await localNotifyManager.deleteNotification(0);},
            child: Text("delete")
          ),
          ]
      ),
    );
  }
}