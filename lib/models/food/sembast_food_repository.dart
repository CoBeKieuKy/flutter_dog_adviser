import 'package:sembast/sembast.dart';
import 'package:get_it/get_it.dart';

import 'food.dart';
import 'food_repository.dart';

class SembastFoodRepository extends FoodRepository{
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("food_store");

  @override
  Future<int> insertFood(Food food) async {
    return await _store.add(_database, food.toMap());
  }

  @override
  Future deleteFood(int foodId) async{
    await _store.record(foodId).delete(_database);
  }

  @override
  Future<List<Food>> getAllFoods() async {
    final finder = Finder(sortOrders: [
      SortOrder('foodName'),
    ]);
    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => Food.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  @override
  Future<List<Food>> getAllFormulaFoods() async {
    final finder = Finder(sortOrders: [ SortOrder('foodName'),
    ], filter: Filter.equals("foodType", "Formula"));
    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => Food.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  @override
  Future<List<Food>> getAllRawFoods() async {
    final finder = Finder(filter: Filter.equals("foodType", "Raw"),
        sortOrders: [SortOrder('foodName'),
    ]);
    final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => Food.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }
}
