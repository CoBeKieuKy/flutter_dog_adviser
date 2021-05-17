import 'notify.dart';

abstract class NotifyRepository {

  Future<int> insertNotify(Notify notify);

  Future updateNotify(Notify notify);

  Future deleteNotify(int notifyId);

  Future<List<Notify>> getAllNotifys();
}