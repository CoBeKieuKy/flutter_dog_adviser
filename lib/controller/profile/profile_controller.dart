import 'package:flutter_dog_adviser/models/profile/profile_repository.dart';
import 'package:flutter_dog_adviser/models/user_dog/user_dog.dart';
import 'package:get_it/get_it.dart';

class ProfileController {
  ProfileRepository _profileRepository = GetIt.I.get<ProfileRepository>();
  ProfileController();

  loadProfiles(UserDog userDog) async {
    return await _profileRepository.getAllProfiles(userDog);
  }

  insertProfile(int userDogId, double dogHeight, double dogWeight, double dogBMI, double dogDER, int time) async{
    return await _profileRepository.insertProfile(userDogId, dogHeight, dogWeight, dogBMI, dogDER, time);
  }
  deleteUserDog(UserDog userDog) async {
    await _profileRepository.deleteProfile(userDog);
  }
}