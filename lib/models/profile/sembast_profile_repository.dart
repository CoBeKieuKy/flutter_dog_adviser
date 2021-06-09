import 'package:flutter_dog_adviser/models/user_dog/user_dog.dart';
import 'package:sembast/sembast.dart';
import 'package:get_it/get_it.dart';

import 'profile.dart';
import 'profile_repository.dart';

class SembastProfileRepository extends ProfileRepository{
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("profile_store");

  @override
  Future<List<Profile>> getAllProfiles(UserDog userDog) async {
    final finder = Finder(
      filter: Filter.equals('userDogId', userDog.userDogId),
      sortOrders: [ SortOrder('time',false),]
    );
    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => Profile.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  @override
  Future deleteProfile(UserDog userDog) async {
    final finder = Finder(filter: Filter.equals("userDogId", userDog.userDogId));
    await _store.delete(_database, finder:finder);
  }

  @override
  Future insertProfile(int userDogId, double dogHeight, double dogWeight, double dogBMI, double dogDER, int time) async {
    await _store.add(_database, {
      "userDogId": userDogId,
      "dogWeight": dogWeight,
      "dogHeight": dogHeight,
      "dogBMI": dogBMI,
      "dogDER": dogDER,
      "time": time,
    });
  }
}
