class  Notify{
  int notifyId;
  String notifyTitle;
  String notifyInfo;
  int notifyHour;
  int notifyMin;
  int t2Id;
  int t3Id;
  int t4Id;
  int t5Id;
  int t6Id;
  int t7Id;
  int t8Id;
  int notifyActive;

  Notify({
    this.notifyId,
    this.notifyTitle,
    this.notifyInfo,
    this.notifyHour,
    this.notifyMin,
    this.notifyActive,
    this.t2Id,
    this.t3Id,
    this.t4Id,
    this.t5Id,
    this.t6Id,
    this.t7Id,
    this.t8Id,
  });

  Map<String, dynamic> toMap() {
    return {
      'notifyTitle': this.notifyTitle,
      'notifyInfo': this.notifyInfo,
      'notifyHour': this.notifyHour,
      'notifyMin': this.notifyMin,
      'notifyActive': this.notifyActive,
      't2Id': this.t2Id,
      't3Id': this.t3Id,
      't4Id': this.t4Id,
      't5Id': this.t5Id,
      't6Id': this.t6Id,
      't7Id': this.t7Id,
      't8Id': this.t8Id,
    };
  }

  factory Notify.fromMap(int id, Map<String, dynamic> map) {
    return Notify(
      notifyId: id,
      notifyTitle: map['notifyTitle'],
      notifyInfo: map['notifyInfo'],
      notifyHour: map['notifyHour'],
      notifyMin: map['notifyMin'],
      notifyActive: map['notifyActive'],
      t2Id: map['t2Id'],
      t3Id: map['t3Id'],
      t4Id: map['t4Id'],
      t5Id: map['t5Id'],
      t6Id: map['t6Id'],
      t7Id: map['t7Id'],
      t8Id: map['t8Id'],
    );
  }
}