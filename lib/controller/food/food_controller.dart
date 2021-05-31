import 'package:flutter_dog_adviser/models/food/food_repository.dart';
import 'package:get_it/get_it.dart';

class FoodController {
  FoodRepository _foodRepository = GetIt.I.get<FoodRepository>();
  FoodController();

  getAllFoods() async {
    return await _foodRepository.getAllFoods();
  }

  getAllRawFoods() async {
    return await _foodRepository.getAllRawFoods();
  }

  getAllFormulaFoods() async {
    return await _foodRepository.getAllFormulaFoods();
  }
}