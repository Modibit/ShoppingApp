class Branch {
  String _name;
  int _id;
  String _tel;
  double _lat;
  double _lng;
  String _manager;

  Branch(this._name, this._id, this._tel, this._lat, this._lng, this._manager);

  String get manager => _manager;

  double get lng => _lng;

  double get lat => _lat;

  String get tel => _tel;

  int get id => _id;

  String get name => _name;
}
