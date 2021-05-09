import 'package:flutter_dog_adviser/models/dog/dog.dart';

abstract class DogRepository {

  Future<int> insertDog(Dog dog);

  Future updateDog(Dog dog);

  Future deleteDog(int dogId);

  Future findDog(String dogName);

  Future<List<Dog>> getAllDogs();
}