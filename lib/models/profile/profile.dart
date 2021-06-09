class Profile {
  int profileId;
  int userDogId;
  double dogWeight;
  double dogHeight;
  double dogBMI;
  double dogDER;
  int time;

  Profile({
    this.profileId,
    this.userDogId,
    this.dogWeight,
    this.dogHeight,
    this.dogBMI,
    this.dogDER,
    this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'userDogId': this.userDogId,
      'dogWeight': this.dogWeight,
      'dogHeight': this.dogHeight,
      'dogBMI': this.dogBMI,
      'dogDER': this.dogDER,
      'month': this.time,
    };
  }

  factory Profile.fromMap(int id, Map<String, dynamic> map) {
    return Profile(
      profileId: id,
      userDogId: map['userDogId'],
      dogHeight: map['dogHeight'],
      dogWeight: map['dogWeight'],
      dogBMI: map['dogBMI'],
      dogDER: map['dogDER'],
      time: map['time'],
    );
  }
}