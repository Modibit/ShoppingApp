import 'package:flutter/material.dart';
import 'Product.dart';
import 'ShoppingBasketData.dart';

typedef OnDeletePressed(index);

class ShoppingBasketItem extends StatefulWidget {
  ShoppingBasketItem(this._product, this._onDeletePressed, this._index);
  final Product _product;
  int _count = 1;
  late int _index;
  late OnDeletePressed _onDeletePressed;
  @override
  State<ShoppingBasketItem> createState() => _ShoppingBasketItemState();
}

class _ShoppingBasketItemState extends State<ShoppingBasketItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        height: 200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Image.network(
                widget._product.imgUrl,
                height: 120,
                width: 120,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20),
                  child: Text(
                    widget._product.productname,
                    style: TextStyle(fontFamily: "Yekan", fontSize: 15),
                  ),
                ),
                Container(
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: Increament,
                          child: Icon(
                            Icons.plus_one,
                            size: 20,
                            color: Colors.green[400],
                          ),
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 20,
                        color: Colors.black54,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        widget._count.toString(),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        width: 2,
                        height: 20,
                        color: Colors.black54,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: Decreament,
                          child: Icon(
                            Icons.exposure_minus_1,
                            size: 20,
                            color: Colors.red[500],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 10, left: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: (() {
                              widget._onDeletePressed(widget._index);
                            }),
                            child: Icon(Icons.delete_outline)),
                        Text(
                          widget._product.price,
                          style: TextStyle(fontFamily: "Yekan", fontSize: 15),
                        )
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void Increament() {
    setState(() {
      widget._count++;
    });
  }

  void Decreament() {
    setState(() {
      widget._count--;
      if (widget._count == 0) {
        widget._onDeletePressed(widget._index);
        return;
      }
    });
  }
}
