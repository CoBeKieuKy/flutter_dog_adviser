import 'package:flutter_dog_adviser/models/dog/dog.dart';
import 'package:flutter_dog_adviser/models/dog/dog_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:tflite/tflite.dart';
import 'dart:io';

class DogController {
  DogRepository _dogRepository = GetIt.I.get<DogRepository>();
  DogController();

  loadDogs() async {
    return await _dogRepository.getAllDogs();
  }

  deleteDog(Dog dog) async {
    await _dogRepository.deleteDog(dog.dogId);
  }

  findDog (String dogName) async {
    return await _dogRepository.findDog(dogName);
  }

  addDog() async {

    String name ="Shih Tzu";
    String nation ="China";
    String tags ="Friendly";

    String status ="Life span:	10–18 years\nColor:		gold, brown, white, black, grey\nHeight:		20–28 cm\nWeight:	4–7.5 kg";
    String info = "The Shih Tzu is an Asian toy dog breed. This breed is well-known for their short snout and large round eyes, as well as their ever growing coat, floppy ears, and short and stout posture. Although small in size, they are notorious for their largely fun and playful personality, and calm and friendly temperament. They are highly independent dogs, and are able to adapt well in different situations. Though, due to their independent nature, they are not considered the most obedient breed.";
    final newDog = Dog(dogName: name, dogImage: "assets/images/shih_tzu.jpg", dogNation: nation,
        dogStatistics: status, dogInfo: info, dogTags: tags);

    await _dogRepository.insertDog(newDog);
  }

  void loadModel() async {
    await Tflite.loadModel(
      labels: "assets/tflite/labels.txt",
      model: "assets/tflite/graph.lite",
    );
  }
  runModelOnImage(File file) async {
    return await Tflite.runModelOnImage(path: file.path,
        numResults: 2,
        threshold: 0.1,
        imageMean: 127.5,
        imageStd: 127.5);
  }
}