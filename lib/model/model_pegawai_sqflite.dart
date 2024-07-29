class ModelPegawaiSqflite{

  int? _id;
  String? _firstName, _lastName, _mobileNo, _emailId;
  ModelPegawaiSqflite(this._firstName,
      this._lastName,
      this._mobileNo,
      this._emailId,
      );

  int get id => _id ?? 0;
  String get firstName => _firstName ?? "";
  String get lastName => _lastName ?? "";
  String get mobileNo => _mobileNo ?? "";
  String get emailId => _emailId ?? "";

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{};

    if(_id != null){
      map["id"] = _id;
    }

    map["firstName"] = _firstName;
    map["lastName"] = _lastName;
    map["mobileNo"] = _mobileNo;
    map["emailId"] = _emailId;

    return map;
  }

  ModelPegawaiSqflite.fromMap(Map<String, dynamic> map){
    _id = map["id"];
    _firstName = map["firstName"];
    _lastName = map["lastName"];
    _mobileNo = map["mobileNo"];
    _emailId = map["emailId"];
  }

}