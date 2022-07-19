class LoginResponseModel {
  
  int _result;
  String _message;

  LoginResponseModel(this._result, this._message);

  int get result => _result;

  String get message => _message;

}
