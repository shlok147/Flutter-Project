class P_Details {
  int? _UserID;
  late String _Name;
  late String _Email;
  late String _Phone;
  late String _Date_Birth;
  late String _City;
  late String _Gender;
  late String _Hobbies;
  late String _Password;
  bool _isFavourite = false;
  late String _ImagePath;

  int? get UserID => _UserID;

  set UserID(int? value) {
    _UserID = value;
  }

  bool get isFavourite => _isFavourite;

  set isFavourite(bool value) {
    _isFavourite = value;
  }

  String get Name => _Name;

  set Name(String value) {
    _Name = value;
  }

  String get Email => _Email;

  String get Password => _Password;

  set Password(String value) {
    _Password = value;
  }

  String get Hobbies => _Hobbies;

  set Hobbies(String value) {
    _Hobbies = value;
  }

  String get Gender => _Gender;

  set Gender(String value) {
    _Gender = value;
  }

  String get City => _City;

  set City(String value) {
    _City = value;
  }

  String get Date_Birth => _Date_Birth;

  set Date_Birth(String value) {
    _Date_Birth = value;
  }

  String get Phone => _Phone;

  set Phone(String value) {
    _Phone = value;
  }

  set Email(String value) {
    _Email = value;
  }

  String get ImagePath => _ImagePath;

  set ImagePath(String value) {
    _ImagePath = value;
  }

  @override
  String toString() {
    return 'P_Details{UserID: $_UserID, Name: $_Name, Email: $_Email, Phone: $_Phone, Date_Birth: $_Date_Birth, City: $_City, Gender: $_Gender, Hobbies: $_Hobbies, Password: $_Password, isFavourite: $_isFavourite, ImagePath: $_ImagePath}';
  }

  Map<String, dynamic> toMap() {
    return {
      'UserID': this._UserID,
      'Name': this._Name,
      'Email': this._Email,
      'Phone': this._Phone,
      'Date_Birth': this._Date_Birth,
      'City': this._City,
      'Gender': this._Gender,
      'Hobbies': this._Hobbies,
      'Password': this._Password,
      'isFavourite': this._isFavourite,
      'ImagePath': this._ImagePath,
    };
  }

  P_Details();

  P_Details.fromMap(Map<String, dynamic> map) {
    this.UserID = map['UserID'];
    this.Name = map['Name'];
    this.Email = map['Email'];
    this.Phone = map['Phone'];
    this.Date_Birth = map['Date_Birth'];
    this.City = map['City'];
    this.Gender = map['Gender'];
    this.Hobbies = map['Hobbies'];
    this.Password = map['Password'];
    this.ImagePath = map['ImagePath'];
    this.isFavourite = map['isFavourite'] == 1;
  }
}
