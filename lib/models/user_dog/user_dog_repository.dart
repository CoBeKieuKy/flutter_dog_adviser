import 'user_dog.dart';

abstract class UserDogRepository {

  Future<List<UserDog>> getAllUserDogs();

  Future<int> insertUserDog(String userDogName, String userDogBreed, String userDogGender, String userDogImage);

  Future deleteUserDog(UserDog userDogId);
}