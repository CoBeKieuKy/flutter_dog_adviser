import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle2.dart';
import 'package:flutter_dog_adviser/models/notify/notify.dart';
import 'package:flutter_dog_adviser/models/notify/notify_repository.dart';
import 'package:get_it/get_it.dart';

import 'notify_details.dart';


class NotifyList extends StatefulWidget {
  _NotifyListState createState() => _NotifyListState();
}

class _NotifyListState extends State<NotifyList>{
  NotifyRepository _notifyRepository = GetIt.I.get<NotifyRepository>();
  List<Notify> _notifys = [];

  @override
  void initState() {
    super.initState();
    _loadNotifys();
  }

  _loadNotifys() async {
    final notifys = await _notifyRepository.getAllNotifys();
    setState(() => _notifys = notifys);
  }

  _deleteNotify(Notify notify) async {
    await _notifyRepository.deleteNotify(notify.notifyId);
    _loadNotifys();
  }

  _addNotify() async {
    final newNotify = Notify(
        notifyHour: 0,
        notifyMin: 0,
        notifyActive: 0,
        notifyTitle: "New Notification",
        notifyType: "Default",
        notifyInfo: "Empty",
        t2Id: 0,
        t3Id: 0,
        t4Id: 0,
        t5Id: 0,
        t6Id: 0,
        t7Id: 0,
        t8Id: 0,
    );
    await _notifyRepository.insertNotify(newNotify);
    _loadNotifys();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBarSection("Notification List"),

      drawer: SafeArea(
        child: DrawerSection(),
      ),
      body:  ListView.builder(
          itemCount: _notifys.length,
          itemBuilder: (context, index) {
            final notify = _notifys[index];
            return
              Card(
                child: ListTile(
                  title: TextSubtitle(notify.notifyTitle),
                  subtitle: TextSubtitle2(notify.notifyType),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteNotify(notify),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NotifyDetails(notifyItem: notify,))
                    );
                  },
                ),
              );
          }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addNotify,
      ),
    );
  }
}