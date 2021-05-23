class BMI {
  int bmiId;
  String gender;
  int underWeight;
  int overWeight;
  String dogName;


  BMI({
    this.bmiId,
    this.gender,
    this.dogName,
    this.underWeight,
    this.overWeight,
  });

  Map<String, dynamic> toMap() {
    return {
      'dogName': this.dogName,
      'gender': this.gender,
      'underWeight': this.underWeight,
      'overWeight': this.overWeight,
    };
  }

  factory BMI.fromMap(int id, Map<String, dynamic> map) {
    return BMI(
      bmiId: id,
      dogName: map['dogName'],
      gender: map['gender'],
      underWeight: map['underWeight'],
      overWeight: map['overWeight'],
    );
  }
}