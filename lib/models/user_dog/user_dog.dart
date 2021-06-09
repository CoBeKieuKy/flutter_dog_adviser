class UserDog {
  int userDogId;
  String userDogName;
  String userDogGender;
  String userDogBreed;
  String userDogImage;

  UserDog({
    this.userDogId,
    this.userDogGender,
    this.userDogBreed,
    this.userDogName,
    this.userDogImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'userDogId': this.userDogId,
      'userDogGender': this.userDogGender,
      'userDogName': this.userDogName,
      'userDogBreed': this.userDogBreed,
      'userDogImage': this.userDogImage,
    };
  }

  factory UserDog.fromMap(int id, Map<String, dynamic> map) {
    return UserDog(
      userDogId: id,
      userDogGender: map['userDogGender'],
      userDogName: map['userDogName'],
      userDogBreed: map['userDogBreed'],
      userDogImage: map['userDogImage']
    );
  }
}