import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_section.dart';
import 'package:flutter_dog_adviser/models/notify/notify.dart';
import 'package:flutter_dog_adviser/models/notify/notify_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:flutter_dog_adviser/notification/local_notify_manager.dart';



class NotifyDetails extends StatefulWidget {
  final Notify notifyItem;
  NotifyDetails({Key key, this.notifyItem}) : super(key: key);
  _NotifyDetailsState createState() => _NotifyDetailsState();
}

class _NotifyDetailsState extends State<NotifyDetails>{
  TimeOfDay time;
  TimeOfDay picked;
  var values = List.filled(7, false);
  NotifyRepository _notifyRepository = GetIt.I.get<NotifyRepository>();

  _updateNotify(Notify notify) async {
    notify.notifyHour = time.hour;
    notify.notifyMin = time.minute;
    notify.t2Id = 0;
    notify.t3Id = 0;
    notify.t4Id = 0;
    notify.t5Id = 0;
    notify.t6Id = 0;
    notify.t7Id = 0;
    notify.t8Id = 0;

    if(values[0])
      notify.t8Id = 8 + notify.notifyId*10;
    if(values[1])
      notify.t2Id = 2 + notify.notifyId*10;
    if(values[2])
      notify.t3Id = 3 + notify.notifyId*10;
    if(values[3])
      notify.t4Id = 4 + notify.notifyId*10;
    if(values[4])
      notify.t5Id = 5 + notify.notifyId*10;
    if(values[5])
      notify.t6Id = 6 + notify.notifyId*10;
    if(values[6])
      notify.t7Id = 7 + notify.notifyId*10;

    await _notifyRepository.updateNotify(notify);
    print("Updated!");
  }

  _activate(Notify notify) async{
    if(notify.t2Id > 0)
      await localNotifyManager.scheduleWeeklyNotification(notify.t2Id, notify.notifyHour, notify.notifyMin, 1);
    if(notify.t3Id > 0)
      await localNotifyManager.scheduleWeeklyNotification(notify.t2Id, notify.notifyHour, notify.notifyMin, 2);
    if(notify.t4Id > 0)
      await localNotifyManager.scheduleWeeklyNotification(notify.t2Id, notify.notifyHour, notify.notifyMin, 3);
    if(notify.t5Id > 0)
      await localNotifyManager.scheduleWeeklyNotification(notify.t2Id, notify.notifyHour, notify.notifyMin, 4);
    if(notify.t6Id > 0)
      await localNotifyManager.scheduleWeeklyNotification(notify.t2Id, notify.notifyHour, notify.notifyMin, 5);
    if(notify.t7Id > 0)
      await localNotifyManager.scheduleWeeklyNotification(notify.t2Id, notify.notifyHour, notify.notifyMin, 6);
    if(notify.t8Id > 0)
      await localNotifyManager.scheduleWeeklyNotification(notify.t2Id, notify.notifyHour, notify.notifyMin, 7);
  }

  _deactivate(Notify notify) async{
    await localNotifyManager.deleteNotification(0);
    // if(notify.t2Id > 0)
    //   await localNotifyManager.deleteNotification(notify.t2Id);
    // if(notify.t3Id > 0)
    //   await localNotifyManager.deleteNotification(notify.t3Id);
    // if(notify.t4Id > 0)
    //   await localNotifyManager.deleteNotification(notify.t4Id);
    // if(notify.t5Id > 0)
    //   await localNotifyManager.deleteNotification(notify.t5Id);
    // if(notify.t6Id > 0)
    //   await localNotifyManager.deleteNotification(notify.t6Id);
    // if(notify.t7Id > 0)
    //   await localNotifyManager.deleteNotification(notify.t7Id);
    // if(notify.t8Id > 0)
    //   await localNotifyManager.deleteNotification(notify.t8Id);
  }
  @override
  void initState(){
    super.initState();
    time = TimeOfDay.now();
  }

  Future<Null> selectTime(BuildContext context) async{
    picked = await showTimePicker(
        context: context,
        initialTime: time
    );
    if(picked != null){
      setState(() {
        time = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBarSection("Notify Details"),

        drawer: SafeArea(
          child: DrawerSection(),
        ),

        body: SingleChildScrollView (
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              WeekdaySelector(
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
              IconButton(
                icon: Icon(Icons.alarm),
                iconSize: 40,
                onPressed: (){
                  selectTime(context);
                  print(time);
                },
              ),
              Text('Time ${time.hour}:${time.minute}',style: TextStyle(fontSize: 25),),
              TextSection(widget.notifyItem.notifyTitle,widget.notifyItem.notifyType, widget.notifyItem.notifyActive.toString(),
                  widget.notifyItem.notifyInfo,widget.notifyItem.notifyType),
              Text(widget.notifyItem.t2Id.toString()+" "+widget.notifyItem.t3Id.toString()),
              Text(widget.notifyItem.t4Id.toString()+" "+widget.notifyItem.t5Id.toString()),
              Text(widget.notifyItem.t6Id.toString()+" "+widget.notifyItem.t7Id.toString()),
              Text(widget.notifyItem.t8Id.toString()+" "+widget.notifyItem.notifyHour.toString()),

              FlatButton(
                  onPressed: () async {
                      await _updateNotify(widget.notifyItem);
                    },
                    child:Text("Update")
              ),
              FlatButton(
                  onPressed: () async {
                    await _activate(widget.notifyItem);
                  },
                  child:Text("Activate")
              ),
              FlatButton(
                  onPressed: () async {
                    await _deactivate(widget.notifyItem);
                  },
                  child:Text("Deactivate")
              ),
            ],
          ),
        )
    );
  }
}