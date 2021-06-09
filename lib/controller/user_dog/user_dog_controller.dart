import 'package:flutter_dog_adviser/models/user_dog/user_dog.dart';
import 'package:flutter_dog_adviser/models/user_dog/user_dog_repository.dart';
import 'package:get_it/get_it.dart';

class UserDogController {
  UserDogRepository _userDogRepository = GetIt.I.get<UserDogRepository>();
  UserDogController();

  loadUserDogs() async {
    return await _userDogRepository.getAllUserDogs();
  }

  Future<int> insertUserDog(String userDogName, String userDogBreed, String userDogGender, String userDogImage) async {
    return await _userDogRepository.insertUserDog(userDogName, userDogBreed, userDogGender, userDogImage);
  }

  deleteUserDog(UserDog userDog) async {
    await _userDogRepository.deleteUserDog(userDog);
  }
}