import 'food.dart';

abstract class FoodRepository {

  Future<List<Food>> getAllRawFoods();

  Future<List<Food>> getAllFormulaFoods();

  Future<List<Food>> getAllFoods();
}