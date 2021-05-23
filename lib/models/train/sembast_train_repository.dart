import 'package:sembast/sembast.dart';
import 'package:get_it/get_it.dart';

import 'train.dart';
import 'train_repository.dart';

class SembastTrainRepository extends TrainRepository{
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("train_store");

  @override
  Future<int> insertTrain(Train train) async {
    return await _store.add(_database, train.toMap());
  }

  @override
  Future deleteTrain(int trainId) async{
    await _store.record(trainId).delete(_database);
  }

  @override
  Future<List<Train>> getAllTrains() async {
    final finder = Finder(sortOrders: [
      SortOrder('trainName'),
    ]);
    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => Train.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }
}
