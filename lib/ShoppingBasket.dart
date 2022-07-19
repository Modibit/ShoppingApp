import 'package:flutter/material.dart';
import 'Product.dart';
import 'ShoppingBasketData.dart';
import 'ShoppingBasketItem.dart';

class ShoppingBasket extends StatefulWidget {
  const ShoppingBasket({Key? key}) : super(key: key);

  @override
  State<ShoppingBasket> createState() => _ShoppingBasketState();
}

class _ShoppingBasketState extends State<ShoppingBasket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("سبد خرید"),
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
      body: BasketUi(),
    );
  }

  Widget BasketUi() {
    return Stack(children: [
      ListView.builder(
        padding: const EdgeInsets.only(bottom: 60),
        itemCount: ShoppingBasketData.getInstance().basketItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ShoppingBasketItem(
                  ShoppingBasketData.getInstance().basketItems[index],
                  DeleteItem,
                  index),
            ),
          );
        },
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Colors.red[500],
            ),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: Text(
              "پرداخت",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Yekan", color: Colors.white, fontSize: 25),
            ),
          ),
        ),
      )
    ]);
  }

  void DeleteItem(index) {
    setState(() {
      ShoppingBasketData.getInstance().basketItems.removeAt(index);
    });
  }
}
