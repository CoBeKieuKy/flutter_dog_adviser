import 'package:flutter_dog_adviser/models/train/train.dart';
import 'package:flutter_dog_adviser/models/train/train_repository.dart';
import 'package:get_it/get_it.dart';

class TrainController {
  TrainRepository _trainRepository = GetIt.I.get<TrainRepository>();
  TrainController();

  getAllTrains() async {
    return await _trainRepository.getAllTrains();
  }

  addTrain() async {
    String trainName ="Poles Jumping";
    String info ="Jumping can place a lot of strain on your dog’s muscles and the joints, so it is important to begin training your dog when it is fully grown. When the time is right, training can be done by the following step\nStep 1\nSelect a word such as “over” or “jump.” to command your dog. Use your chosen command or cue consistently throughout the training.\nStep 2\nIntroduce your dog to the jumping poles. Place your dog on a leash and bring it toward the jumping poles. Let him be familiar with jumping poles at first. Let him walk over a lowered pole.\nStep 3\nOnce your dog has successfully walked over the pole several times, make it a little more challenging by raising the pole to the next. After the dog jumps over, reward it with praise and give it the treat.\nStep 4\nRepeat and take the bar higher but be sure that the jumping pole does not exceed the height of your dog.";



    String trainImage = "assets/images/train/jump.PNG";
    String trainFor = "For Adult dog";  //  For Adult dog   For All kinds

    final newTrain = Train(trainName: trainName, trainImage: trainImage,
        trainFor: trainFor, trainInfo: info
    );
    await _trainRepository.insertTrain(newTrain);
  }

  deleteTrain(Train train) async {
    await _trainRepository.deleteTrain(train.trainId);
  }
}