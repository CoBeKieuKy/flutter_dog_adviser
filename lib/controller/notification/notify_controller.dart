import 'package:flutter/material.dart';
import 'package:flutter_dog_adviser/models/notify/notify_repository.dart';
import 'package:flutter_dog_adviser/controller/notification/local_notify_manager.dart';
import 'package:flutter_dog_adviser/models/notify/notify.dart';
import 'package:get_it/get_it.dart';

class NotifyController {
  NotifyRepository _notifyRepository = GetIt.I.get<NotifyRepository>();
  NotifyController ();

  loadNotifys () async {
    return await _notifyRepository.getAllNotifys();
  }

  deleteNotify (Notify notify) async {
    await deactivate(notify);
    await _notifyRepository.deleteNotify(notify.notifyId);
  }

  addNotify () async {
    final newNotify = Notify(
      notifyHour: 0,
      notifyMin: 0,
      notifyActive: 0,
      notifyTitle: "New Notification",
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
  }

  updateNotify(Notify notify, List values, TimeOfDay time, String title, String info) async {
    await deactivate(notify);
    notify.notifyTitle = title;
    notify.notifyInfo = info;
    notify.notifyHour = time.hour;
    notify.notifyMin = time.minute;
    notify.t2Id = 0;
    notify.t3Id = 0;
    notify.t4Id = 0;
    notify.t5Id = 0;
    notify.t6Id = 0;
    notify.t7Id = 0;
    notify.t8Id = 0;

    if (values[0])
      notify.t8Id = 8 + notify.notifyId * 10;
    if (values[1])
      notify.t2Id = 2 + notify.notifyId * 10;
    if (values[2])
      notify.t3Id = 3 + notify.notifyId * 10;
    if (values[3])
      notify.t4Id = 4 + notify.notifyId * 10;
    if (values[4])
      notify.t5Id = 5 + notify.notifyId * 10;
    if (values[5])
      notify.t6Id = 6 + notify.notifyId * 10;
    if (values[6])
      notify.t7Id = 7 + notify.notifyId * 10;

    await _notifyRepository.updateNotify(notify);
    if(notify.notifyActive==1)
      await activate(notify);
    else
      await deactivate(notify);
    print("Updated!");
  }

  activate(Notify notify) async{
    if(notify.t2Id > 0) {
      await localNotifyManager.scheduleWeeklyNotification(
          notify.t2Id, notify.notifyHour, notify.notifyMin, 1, notify.notifyTitle, notify.notifyInfo);
    }
    if(notify.t3Id > 0){
      await localNotifyManager.scheduleWeeklyNotification(
          notify.t3Id, notify.notifyHour, notify.notifyMin, 2, notify.notifyTitle, notify.notifyInfo);
    }
    if(notify.t4Id > 0){
      await localNotifyManager.scheduleWeeklyNotification(
          notify.t4Id, notify.notifyHour, notify.notifyMin, 3, notify.notifyTitle, notify.notifyInfo);
    }
    if(notify.t5Id > 0) {
      await localNotifyManager.scheduleWeeklyNotification(
          notify.t5Id, notify.notifyHour, notify.notifyMin, 4, notify.notifyTitle, notify.notifyInfo);
    }
    if(notify.t6Id > 0) {
      await localNotifyManager.scheduleWeeklyNotification(
          notify.t6Id, notify.notifyHour, notify.notifyMin, 5, notify.notifyTitle, notify.notifyInfo);
    }
    if(notify.t7Id > 0) {
      await localNotifyManager.scheduleWeeklyNotification(
          notify.t7Id, notify.notifyHour, notify.notifyMin, 6, notify.notifyTitle, notify.notifyInfo);
    }
    if(notify.t8Id > 0) {
      await localNotifyManager.scheduleWeeklyNotification(
          notify.t8Id, notify.notifyHour, notify.notifyMin, 7, notify.notifyTitle, notify.notifyInfo);
    }
  }

  deactivate(Notify notify) async{
    if(notify.t2Id > 0)
      await localNotifyManager.deleteNotification(notify.t2Id);
    if(notify.t3Id > 0)
      await localNotifyManager.deleteNotification(notify.t3Id);
    if(notify.t4Id > 0)
      await localNotifyManager.deleteNotification(notify.t4Id);
    if(notify.t5Id > 0)
      await localNotifyManager.deleteNotification(notify.t5Id);
    if(notify.t6Id > 0)
      await localNotifyManager.deleteNotification(notify.t6Id);
    if(notify.t7Id > 0)
      await localNotifyManager.deleteNotification(notify.t7Id);
    if(notify.t8Id > 0)
      await localNotifyManager.deleteNotification(notify.t8Id);
  }

  deactivateAll() async {
    await localNotifyManager.deleteAllNotification();
    print("Delete All");
  }
}