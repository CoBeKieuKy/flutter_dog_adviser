import 'package:flutter_dog_adviser/models/bmi/bmi_repository.dart';
import 'package:get_it/get_it.dart';

class BMIController {
  BMIRepository _bmiRepository = GetIt.I.get<BMIRepository>();
  BMIController();

  findDogBMI(dogName, gender) async {
    return await _bmiRepository.findDogBMI(dogName, gender);
  }
}