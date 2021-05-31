import 'package:flutter_dog_adviser/models/train/train_repository.dart';
import 'package:get_it/get_it.dart';

class TrainController {
  TrainRepository _trainRepository = GetIt.I.get<TrainRepository>();
  TrainController();

  getAllTrains() async {
    return await _trainRepository.getAllTrains();
  }
}