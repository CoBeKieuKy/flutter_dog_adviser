import 'package:flutter_dog_adviser/models/dog/dog.dart';

abstract class DogRepository {

  Future findDog(String dogName);

  Future<List<Dog>> getAllDogs();
}