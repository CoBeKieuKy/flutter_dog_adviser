import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/controller/notification/notify_controller.dart';
import 'package:flutter_dog_adviser/custom_widgets/appbar_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/drawer_section.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle.dart';
import 'package:flutter_dog_adviser/custom_widgets/text_subtitle2.dart';
import 'package:flutter_dog_adviser/models/notify/notify.dart';
import 'notify_details.dart';


class NotifyList extends StatefulWidget {
  _NotifyListState createState() => _NotifyListState();
}

class _NotifyListState extends State<NotifyList>{
  List<Notify> _notifys = [];
  NotifyController _notifyListController = NotifyController();

  @override
  void initState() {
    super.initState();
    _loadNotifys();
  }

  _loadNotifys() async {
    final notifys = await _notifyListController.loadNotifys();
    setState(() => _notifys = notifys);
  }

  _deleteNotify(Notify notify) async {
    await _notifyListController.deleteNotify(notify);
    _loadNotifys();
  }

  _addNotify() async {
    await _notifyListController.addNotify();
    _loadNotifys();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBarSection("Scheduled Training List"),

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
                  subtitle: TextSubtitle2("Training"),
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