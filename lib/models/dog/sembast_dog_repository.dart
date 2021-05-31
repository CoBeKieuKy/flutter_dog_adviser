import 'package:flutter_dog_adviser/models/dog/dog_repository.dart';
import 'package:sembast/sembast.dart';
import 'package:get_it/get_it.dart';

import 'dog.dart';

class SembastDogRepository extends DogRepository{
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("dog_store");

  @override
  Future<List<Dog>> getAllDogs() async {
    final finder = Finder(sortOrders: [
      SortOrder('dogName'),
    ]);
    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => Dog.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  @override
  Future<List<Dog>> findDog(String dogName) async{
    var finder = Finder(filter: Filter.equals("dogName", dogName));
    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => Dog.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }
}
