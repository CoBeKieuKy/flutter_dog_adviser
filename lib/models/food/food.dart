class Food {
  int foodId;
  String foodName;
  String foodType;
  String foodImage;
  String foodInfo;
  String foodEdible;
  String foodFor;

  Food({
    this.foodId,
    this.foodType,
    this.foodImage,
    this.foodName,
    this.foodInfo,
    this.foodEdible,
    this.foodFor,
  });

  Map<String, dynamic> toMap() {
    return {
      'foodType': this.foodType,
      'foodName': this.foodName,
      'foodImage': this.foodImage,
      'foodInfo': this.foodInfo,
      'foodEdible': this.foodEdible,
      'foodFor': this.foodFor,
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
    );
  }
}