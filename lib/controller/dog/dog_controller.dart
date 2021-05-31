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

  findDog (String dogName) async {
    return await _dogRepository.findDog(dogName);
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