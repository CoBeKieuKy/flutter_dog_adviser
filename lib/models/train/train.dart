class Train {
  int trainId;
  String trainName;
  String trainImage;
  String trainInfo;
  String trainFor;

  Train({
    this.trainId,
    this.trainImage,
    this.trainName,
    this.trainInfo,
    this.trainFor,
  });

  Map<String, dynamic> toMap() {
    return {
      'trainName': this.trainName,
      'trainImage': this.trainImage,
      'trainInfo': this.trainInfo,
      'trainFor': this.trainFor,
    };
  }

  factory Train.fromMap(int id, Map<String, dynamic> map) {
    return Train(
      trainId: id,
      trainName: map['trainName'],
      trainImage: map['trainImage'],
      trainInfo: map['trainInfo'],
      trainFor: map['trainFor'],
    );
  }
}