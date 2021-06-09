class Food {
  int foodId;
  String foodName;
  String foodType;
  String foodImage;
  String foodInfo;
  String foodEdible;
  String foodFor;
  double calories;
  double proteins;
  double carbs;
  double fats;


  Food({
    this.foodId,
    this.foodType,
    this.foodImage,
    this.foodName,
    this.foodInfo,
    this.foodEdible,
    this.foodFor,
    this.calories,
    this.proteins,
    this.carbs,
    this.fats,
  });

  Map<String, dynamic> toMap() {
    return {
      'foodType': this.foodType,
      'foodName': this.foodName,
      'foodImage': this.foodImage,
      'foodInfo': this.foodInfo,
      'foodEdible': this.foodEdible,
      'foodFor': this.foodFor,
      'calories': this.calories,
      'proteins': this.proteins,
      'carbs': this.carbs,
      'fats': this.fats,
    };
  }

  factory Food.fromMap(int id, Map<String, dynamic> map) {
    return Food(
      foodId: id,
      foodType: map['foodType'],
      foodName: map['foodName'],
      foodImage: map['foodImage'],
      foodEdible: map['foodEdible'],
      foodInfo: map['foodInfo'],
      foodFor: map['foodFor'],
      calories: map['calories'],
      proteins: map['proteins'],
      carbs: map['carbs'],
      fats: map['fats'],
    );
  }
}