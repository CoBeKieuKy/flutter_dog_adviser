import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle.dart';
import 'package:flutter_dog_adviser/models/notify/notify.dart';
import 'package:flutter_dog_adviser/controller/notification/notify_controller.dart';
import 'package:weekday_selector/weekday_selector.dart';

class NotifyDetails extends StatefulWidget {
  final Notify notifyItem;
  NotifyDetails({Key key, this.notifyItem}) : super(key: key);
  _NotifyDetailsState createState() => _NotifyDetailsState();
}

class _NotifyDetailsState extends State<NotifyDetails>{
  TimeOfDay time;
  TimeOfDay picked;
  String title;
  String info;
  String status = "Inactive";
  bool status_color = false;
  int pickedHour;
  int pickedMin;
  var values = List.filled(7, false);
  final _formKey = GlobalKey<FormState>();
  NotifyController _notifyDetailsController = NotifyController();

  @override
  void initState(){
    super.initState();
    if(widget.notifyItem.notifyActive==1){
      status = "Active";
      status_color = true;
    }
    pickedHour = widget.notifyItem.notifyHour;
    pickedMin = widget.notifyItem.notifyMin;
    time = TimeOfDay.now();
    if(widget.notifyItem.t8Id > 0)
      values[0] = true;
    if(widget.notifyItem.t2Id > 0)
      values[1] = true;
    if(widget.notifyItem.t3Id > 0)
      values[2] = true;
    if(widget.notifyItem.t4Id > 0)
      values[3] = true;
    if(widget.notifyItem.t5Id > 0)
      values[4] = true;
    if(widget.notifyItem.t6Id > 0)
      values[5] = true;
    if(widget.notifyItem.t7Id > 0)
      values[6] = true;
  }

  Future<Null> selectTime(BuildContext context) async{
    picked = await showTimePicker(
        context: context,
        initialTime: time
    );
    if(picked != null){
      setState(() {
        time = picked;
        pickedHour = time.hour;
        pickedMin = time.minute;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBarSection("Training Note Details"),

        drawer: SafeArea(
          child: DrawerSection(),
        ),

        body: SingleChildScrollView (
          child: Padding(
            padding: EdgeInsets.all(25.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      setState(() {
                        title = value;
                      });
                      return null;
                    },
                    initialValue: widget.notifyItem.notifyTitle,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Training Title",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20.0,
                      bottom: 20,
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        setState(() {
                          info = value;
                        });
                        return null;
                      },
                      initialValue: widget.notifyItem.notifyInfo,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Training Info",
                      ),
                    ),
                  ),
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.0,
                          ),
                          child:Center(child: TextSubtitle("Choose Time and Day"),),
                        ),
                        Padding(
                          child: WeekdaySelector(
                            shortWeekdays: ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"],
                            onChanged: (int day) {
                              setState(() {
                                if(values[day % 7])
                                  values[day % 7] = false;
                                else
                                  values[day % 7] = true;
                              });
                            },
                            selectedFillColor: Colors.green,
                            values: values,
                          ),
                          padding: EdgeInsets.only(
                            top: 20.0,
                          ),
                        ),
                        Padding(
                          child:IconButton(
                            icon: Icon(Icons.alarm),
                            iconSize: 40,
                            onPressed: (){
                              selectTime(context);
                            },
                          ),
                          padding: EdgeInsets.only(
                            top: 20.0,
                          ),
                        ),
                        Center( child:Text('$pickedHour:$pickedMin',style: TextStyle(fontSize: 25),),),
                        Padding(
                          child: ElevatedButton(
                            onPressed: () async {
                              if(widget.notifyItem.notifyActive==0) {
                                widget.notifyItem.notifyActive = 1;
                                setState(() {
                                  status_color = true;
                                  status = "Active";
                                });
                              }
                              else {
                                widget.notifyItem.notifyActive = 0;
                                setState(() {
                                  status_color = false;
                                  status = "Inactive";
                                });
                              }
                            },
                            child: Text(status),
                            style: ElevatedButton.styleFrom(
                              primary: status_color ? Colors.green : Colors.red,),
                          ),
                          padding: EdgeInsets.only(
                            top: 20.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                if(!values.contains(true)){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text('Please choose day of week')));
                                }
                                else {
                                  await _notifyDetailsController.updateNotify(widget.notifyItem, values, time, title, info);
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text('Your Notify has been updated')));
                                }
                              }
                            },
                            child: Text('Update'),
                          ),
                        ),
                      ],
                    ),
                    color: Colors.white70,
                  ),
                  // ElevatedButton(
                  //     onPressed: (){
                  //       _notifyDetailsController.deactivateAll();
                  //     },
                  //     child: Text("delete all")
                  // ),
                ],
              ),
            ),
          ),
        )
    );
  }
}