import 'package:flutter_dog_adviser/models/bmi/bmi.dart';
import 'package:flutter_dog_adviser/models/bmi/bmi_repository.dart';
import 'package:get_it/get_it.dart';

class BMIController {
  BMIRepository _bmiRepository = GetIt.I.get<BMIRepository>();
  BMIController();

  findDogBMI(dogName, gender) async {
    return await _bmiRepository.findDogBMI(dogName, gender);
  }

  addBMI() async {
    String dogName = "Yorkshire Terrier";
    String gender = "female";
    int underWeight = 50;
    int overWeight = 83;

    BMI newBMI = BMI (
      dogName: dogName,
      gender: gender,
      underWeight: underWeight,
      overWeight: overWeight,
    );
    await _bmiRepository.insertBMI(newBMI);
    print("done");
  }

  deleteBMI(BMI bmi) async {
    await _bmiRepository.deleteBMI(bmi.bmiId);
  }

  getAllBMIs() async{
    return _bmiRepository.getAllBMIs();
  }
}