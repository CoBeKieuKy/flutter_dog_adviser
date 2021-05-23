import 'bmi.dart';

abstract class BMIRepository {
  Future<List<BMI>> getAllBMIs();

  Future<int> insertBMI(BMI bmi);

  Future deleteBMI(int bmiId);

  Future findDogBMI(String dogName, String gender);
}