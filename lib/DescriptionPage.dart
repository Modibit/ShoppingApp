import 'package:flutter/material.dart';
import 'ShoppingBasket.dart';
import 'ShoppingBasketData.dart';
import 'Product.dart';

class DescriptionPage extends StatelessWidget {
  Product _product;
  DescriptionPage(this._product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("کفش " + _product.productname),
        titleTextStyle: const TextStyle(
            fontFamily: "Yekan", fontSize: 20, color: Colors.black54),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
      body: Builder(builder: (context) {
        return Column(children: [
          Center(
            child: Image.network(
              _product.imgUrl,
              fit: BoxFit.contain,
              height: 280,
              width: 280,
            ),
          ),
          Text(
            _product.price,
            style: TextStyle(
                fontFamily: "Yekan", fontSize: 35, color: Colors.red[700]),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Text(
              _product.description,
              textDirection: TextDirection.rtl,
              style:
                  const TextStyle(fontFamily: "Yekan", color: Colors.black54),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    ShoppingBasketData.getInstance().setbasketItems(_product,context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red[500],
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width - 50,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "افزودن به سبد خرید",
                        style: TextStyle(
                            fontFamily: "Yekan",
                            fontSize: 20,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]);
      }),
    );
  }
}
