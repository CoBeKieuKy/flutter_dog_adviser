import 'food.dart';

abstract class FoodRepository {

  Future<int> insertFood(Food food);

  Future deleteFood(int foodId);

  Future<List<Food>> getAllRawFoods();

  Future<List<Food>> getAllFormulaFoods();

  Future<List<Food>> getAllFoods();
}