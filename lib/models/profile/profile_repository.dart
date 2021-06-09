import 'package:flutter_dog_adviser/models/user_dog/user_dog.dart';

import 'profile.dart';

abstract class ProfileRepository {

  Future<List<Profile>> getAllProfiles(UserDog userDog);

  Future insertProfile(int userDogId, double dogHeight, double dogWeight, double dogBMI, double dogDER, int time);

  Future deleteProfile(UserDog userDog);
}