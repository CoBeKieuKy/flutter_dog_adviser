import 'package:flutter_dog_adviser/models/user_dog/user_dog.dart';
import 'package:sembast/sembast.dart';
import 'package:get_it/get_it.dart';

import 'user_dog_repository.dart';

class SembastUserDogRepository extends UserDogRepository{
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("user_dog_store");

  @override
  Future<List<UserDog>> getAllUserDogs() async {
    final finder = Finder(sortOrders: [
      SortOrder('userDogName'),
    ]);
    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => UserDog.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  @override
  Future deleteUserDog(UserDog userDog) async {
    await _store.record(userDog.userDogId).delete(_database);
  }

  @override
  Future<int> insertUserDog(String userDogName, String userDogBreed, String userDogGender, String userDogImage) async {
    return await _store.add(_database, {
      "userDogName": userDogName,
      "userDogBreed": userDogBreed,
      "userDogImage": userDogImage,
      "userDogGender": userDogGender,
    });  }
}
