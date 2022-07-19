// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'BranchesPage.dart';
import 'LoginPage.dart';
import 'Product.dart';
import 'ShoppingBasket.dart';
import 'ShoppingBasketData.dart';
import 'BottomNavigation.dart';
import 'package:http/http.dart';
import 'DescriptionPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
     // home: const MyHomePage(title: 'My Store Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Product> _items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FetchItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "فروشگاه",
          style: TextStyle(
            fontFamily: "Yekan",
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return ShoppingBasket();
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          child: child,
                          position:
                              Tween(begin: Offset(1, 0), end: Offset(0, 0))
                                  .animate(CurvedAnimation(
                                      parent: animation, curve: Curves.ease)),
                        );
                      },
                    ),
                  ),
                },
            icon: Icon(
              Icons.shopping_basket,
              color: Colors.black54,
            )),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () => {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BranchesPage())),
                  },
              icon: Icon(
                Icons.map,
                color: Colors.black54,
              )),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(_items.length, (index) {
          return generateitem(_items[index], context);
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: myBottomNav(),
    );
  }

  void FetchItem() async {
    Response response =
        await get(Uri.parse("https://welearn.site/flutter/products_list.json"));
    print(utf8.decode(response.bodyBytes));
    setState(() {
      var productJson = json.decode(utf8.decode(response.bodyBytes));
      for (var i in productJson) {
        var productItem = Product(i["product_name"], i['id'], i['price'],
            i['image_url'], i['off'], i['description']);
        _items.add(productItem);
      }
    });
  }
}

Card generateitem(Product product, context) {
  return Card(
    margin: EdgeInsets.all(10),
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DescriptionPage(product)));
        },
        child: Center(
          child: Column(
            children: [
              Image.network(
                product.imgUrl,
                height: 100,
              ),
              Text(
                product.productname,
                style: TextStyle(
                  fontFamily: "Yekan",
                ),
              ),
              Text(
                product.price,
                style: TextStyle(
                  fontFamily: "Yekan",
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        )),
  );
}
