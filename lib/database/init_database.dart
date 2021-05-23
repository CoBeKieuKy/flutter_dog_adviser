import 'package:flutter_dog_adviser/models/bmi/bmi_repository.dart';
import 'package:flutter_dog_adviser/models/bmi/sembast_bmi_repository.dart';
import 'package:flutter_dog_adviser/models/dog/dog_repository.dart';
import 'package:flutter_dog_adviser/models/dog/sembast_dog_repository.dart';
import 'package:flutter_dog_adviser/models/food/food_repository.dart';
import 'package:flutter_dog_adviser/models/food/sembast_food_repository.dart';
import 'package:flutter_dog_adviser/models/notify/notify_repository.dart';
import 'package:flutter_dog_adviser/models/notify/sembast_notify_repository.dart';
import 'package:flutter_dog_adviser/models/train/sembast_train_repository.dart';
import 'package:flutter_dog_adviser/models/train/train_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class InitDatabase {
  static Future initialize() async {
    await _initSembast();
    _registerRepositories();
  }

  static _registerRepositories(){
    GetIt.I.registerLazySingleton<DogRepository>(() => SembastDogRepository());
    GetIt.I.registerLazySingleton<FoodRepository>(() => SembastFoodRepository());
    GetIt.I.registerLazySingleton<NotifyRepository>(() => SembastNotifyRepository());
    GetIt.I.registerLazySingleton<TrainRepository>(() => SembastTrainRepository());
    GetIt.I.registerLazySingleton<BMIRepository>(() => SembastBMIRepository());
  }

  static Future _initSembast() async {
    final appDir = await getApplicationDocumentsDirectory();
    await appDir.create(recursive: true);
    final databasePath = join(appDir.path, "dog_app.db");
    final database = await databaseFactoryIo.openDatabase(databasePath);
    GetIt.I.registerSingleton<Database>(database);
  }
}