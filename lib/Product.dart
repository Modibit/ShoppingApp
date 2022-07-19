class Product {
  Product(this._productname, this._id, this._price, this._imgUrl, this._off,
      this._description);

  String _productname;
  int _id;
  String _price;
  String _imgUrl;
  bool _off;
  String _description;
  get productname => this._productname;

  get id => this._id;

  get price => this._price;

  get imgUrl => this._imgUrl;

  get off => this._off;

  get description => this._description;
}
