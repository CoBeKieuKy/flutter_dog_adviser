import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotifyManager {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var initSetting;

  Future<void> setup() async {
    tz.initializeTimeZones();
    final String currentTimeZone =  await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
  }

  LocalNotifyManager.init(){
    setup();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    initializePlatform();
  }

  initializePlatform() {
    var initSettingAndroid = AndroidInitializationSettings('dog_icon');
    initSetting = InitializationSettings(android: initSettingAndroid);
    flutterLocalNotificationsPlugin.initialize(initSetting);
    }

  Future<void> deleteNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    print("Delete: "+id.toString());
  }

  Future<void> deleteAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  // Monday
  Future<void> scheduleWeeklyNotification(int id, int hour, int min, int dayOfWeek, String title, String info) async{
    var androidChannel = AndroidNotificationDetails(
      id.toString(),
      'WEEKLY_CHANNEL_NAME',
      'WEEKLY_CHANNEL_DESCRIPTION',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('noti_sound'),
    );
    var platformChannel = NotificationDetails(android: androidChannel);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      info,
      _nextInstanceOfWeekday(hour, min, dayOfWeek),
      platformChannel,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'New Payload',
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
    print("Activate: "+id.toString());
  }
}
LocalNotifyManager localNotifyManager = LocalNotifyManager.init();

//The instance of Weekday
tz.TZDateTime _nextInstanceOfWeekday(int hour, int min, int dayOfWeek) {
  tz.TZDateTime scheduledDate = _nextInstanceOfTime(hour, min);
  switch(dayOfWeek) {
    case 1:
      while (scheduledDate.weekday != DateTime.monday) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }break;
    case 2:
      while (scheduledDate.weekday != DateTime.tuesday) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }break;
    case 3:
      while (scheduledDate.weekday != DateTime.wednesday) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }break;
    case 4:
      while (scheduledDate.weekday != DateTime.thursday) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }break;
    case 5:
      while (scheduledDate.weekday != DateTime.friday) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }break;
    case 6:
      while (scheduledDate.weekday != DateTime.saturday) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }break;
    case 7:
      while (scheduledDate.weekday != DateTime.sunday) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }break;
  }
  return scheduledDate;
}

// The instance of time
tz.TZDateTime _nextInstanceOfTime(int hour, int min) {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate =
  tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, min);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}
