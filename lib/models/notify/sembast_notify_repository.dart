import 'package:sembast/sembast.dart';
import 'package:get_it/get_it.dart';

import 'notify.dart';
import 'notify_repository.dart';

class SembastNotifyRepository extends NotifyRepository{
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("notify_store");

  @override
  Future<int> insertNotify(Notify notify) async {
    return await _store.add(_database, notify.toMap());
  }

  @override
  Future updateNotify(Notify notify) async {
    await _store.record(notify.notifyId).update(_database, notify.toMap());
  }

  @override
  Future deleteNotify(int notifyId) async{
    await _store.record(notifyId).delete(_database);
  }

  @override
  Future<List<Notify>> getAllNotifys() async {
    final finder = Finder(sortOrders: [
      SortOrder('notifyId'),
    ]);
    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => Notify.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }
}
