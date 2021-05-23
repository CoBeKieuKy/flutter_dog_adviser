import 'package:sembast/sembast.dart';
import 'package:get_it/get_it.dart';

import 'bmi.dart';
import 'bmi_repository.dart';

class SembastBMIRepository extends BMIRepository{
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("bmi_store");

  @override
  Future<int> insertBMI(BMI bmi) async {
    return await _store.add(_database, bmi.toMap());
  }

  @override
  Future deleteBMI(int bmiId) async{
    await _store.record(bmiId).delete(_database);
  }

  @override
  Future<List<BMI>> findDogBMI(String dogName, String gender) async{
    var finder = Finder(filter: Filter.and(
        [
          Filter.equals("dogName", dogName),
          Filter.equals("gender", gender),
        ]
    ));

    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => BMI.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  Future<List<BMI>> getAllBMIs() async {
    final finder = Finder(sortOrders: [
      SortOrder('dogName'),
    ]);
    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => BMI.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }
}
