// ignore_for_file: prefer_conditional_assignment, iterable_contains_unrelated_type, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'Product.dart';

class ShoppingBasketData {
  static ShoppingBasketData _instance = ShoppingBasketData();
  late List<Product> _basketItems;
  ShoppingBasketData() {
    _basketItems = <Product>[];
  }

  List<Product> get basketItems => _basketItems;

  void setbasketItems(Product value, context) {
    if (_basketItems.contains(value))
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "آیتم قبلا در سبد موجود می باشد",
          style: TextStyle(fontFamily: "Yekan"),
          textDirection: TextDirection.rtl,
        ),
        duration: Duration(milliseconds: 500),
      ));
    else {
      _basketItems.add(value);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "آیتم به سبد افزوده شد",
          style: TextStyle(
            fontFamily: "Yekan",
          ),
          textDirection: TextDirection.rtl,
        ),
        duration: Duration(milliseconds: 500),
      ));
    }
  }

  static ShoppingBasketData getInstance() {
    // ignore: unnecessary_null_comparison
    if (_instance == null) {
      _instance = ShoppingBasketData();
    }
    return _instance;
  }
}
