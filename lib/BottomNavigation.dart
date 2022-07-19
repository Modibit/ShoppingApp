// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class myBottomNav extends StatelessWidget {
  const myBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 15,
        child: Container(
          height: 70,
          
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => {},
                icon: Icon(Icons.home, size: 30),
              ),
              IconButton(
                onPressed: () => {},
                icon: Icon(Icons.person_outline_outlined, size: 30),
              ),
              SizedBox(width: 0),
              IconButton(
                onPressed: () => {},
                icon: Icon(Icons.search, size: 30),
              ),
              IconButton(
                  onPressed: () => {},
                  icon: Icon(Icons.shopping_basket, size: 30))
            ],
          ),
        )));
  }
}
