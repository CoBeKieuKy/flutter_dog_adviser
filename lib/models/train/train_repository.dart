import 'train.dart';

abstract class TrainRepository {

  Future<int> insertTrain(Train train);

  Future deleteTrain(int trainId);

  Future<List<Train>> getAllTrains();
}