import 'package:flutter_dog_adviser/models/food/food.dart';
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

  addFood() async {
    String foodName ="Eagle Pack";
    String foodType ="Formula"; //  Raw   Formula
    String info = "Eagle Pack Adult Large and Giant Breed is specially formulated with the right amount of fat, protein and carbohydrates to help larger dogs maintain a healthy weight. Dual animal proteins also help provide lean muscle mass.\nThis formula contains no corn, wheat, or meat by-products of any kind and has no artificial colors, flavors or preservatives. Perfectly balanced nutrition for dogs over 50 pounds.";

    String foodEdible ="Edible"; // Edible  Limited  Inedible
    String foodImage = "assets/images/food/fo5food2.jpg";
    String foodFor = "For Adult dog";  //  For Puppy   For Adult dog   For All kinds   For No kinds

    final newFood = Food(foodName: foodName, foodImage: foodImage,
      foodType: foodType, foodFor: foodFor, foodInfo: info,
      foodEdible: foodEdible
    );
    await _foodRepository.insertFood(newFood);
  }

  deleteFood(Food food) async {
    await _foodRepository.deleteFood(food.foodId);
  }
}