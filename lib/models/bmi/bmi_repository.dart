import 'bmi.dart';

abstract class BMIRepository {

  Future<List<BMI>> getAllBMIs();

  Future findDogBMI(String dogName, String gender);
}