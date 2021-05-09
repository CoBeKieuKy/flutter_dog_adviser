class Dog {
  int dogId;
  String dogName;
  String dogNation;
  String dogImage;
  String dogInfo;
  String dogStatistics;
  String dogTags;

  Dog({
    this.dogId,
    this.dogNation,
    this.dogImage,
    this.dogName,
    this.dogInfo,
    this.dogStatistics,
    this.dogTags,
  });

  Map<String, dynamic> toMap() {
    return {
      'dogNation': this.dogNation,
      'dogName': this.dogName,
      'dogImage': this.dogImage,
      'dogInfo': this.dogInfo,
      'dogStatistics': this.dogStatistics,
      'dogTags': this.dogTags,
    };
  }

  factory Dog.fromMap(int id, Map<String, dynamic> map) {
    return Dog(
      dogId: id,
      dogNation: map['dogNation'],
      dogName: map['dogName'],
      dogImage: map['dogImage'],
      dogTags: map['dogTags'],
      dogInfo: map['dogInfo'],
      dogStatistics: map['dogStatistics'],
    );
  }
}