import 'train.dart';

abstract class TrainRepository {

  Future<List<Train>> getAllTrains();
}