import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'LoginResponseModel.dart';
import 'main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginUI(),
    );
  }

  Widget LoginUI() {
    return Builder(
      builder: (context) => Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 80),
            child: Text(
              "Sign in",
              style: TextStyle(
                  fontFamily: "Yekan", fontSize: 55, color: Colors.grey[400]),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: 70, right: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    elevation: 20,
                    borderRadius: BorderRadius.circular(20),
                    shadowColor: Colors.black38,
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        hintText: "نام کاربری",
                        hintStyle: TextStyle(fontFamily: "Yekan"),
                        icon: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Icon(Icons.perm_identity),
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Material(
                    elevation: 20,
                    borderRadius: BorderRadius.circular(20),
                    shadowColor: Colors.black38,
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        hintText: "رمز عبور",
                        hintStyle: TextStyle(fontFamily: "Yekan"),
                        icon: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Icon(Icons.lock_outlined),
                        ),
                      ),
                      obscureText: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Material(
                      elevation: 20,
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red[400],
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: (() {
                          sendLoginRequest(
                              usernameController.text, passwordController.text);
                        }),
                        child: Container(
                          height: 60,
                          child: Center(
                            child: Text(
                              "ورود",
                              style: TextStyle(
                                  fontFamily: "Yekan",
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void sendLoginRequest(
      @required String username, @required String password) async {
    var url = "http://modibitapi.freehost.io/php-auth-api/login.php";
    var body = '{"email":"$username","password":"$password"}';
    //body["username"] = username;
    //body["password"] = password;
    Response response = await post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      var LoginJson = json.decode(utf8.decode(response.bodyBytes));

      LoginResponseModel model =
          LoginResponseModel(LoginJson["success"], LoginJson["message"]);
      print(model.message);
      if (model.result == 0) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Text(
                    model.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "Yekan",
                      fontSize: 15,
                    ),
                  ),
                ));
      } else if (model.result == 1) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          model.message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: "Yekan",
            fontSize: 15,
          ),
        )));

        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) {
              return MyHomePage(
                title: "HomePage",
              );
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                child: child,
                scale: Tween<double>(begin: 0, end: 1).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeIn)),
              );
            },
          ),
        );
      }
    } else {
      print("خطا");
      const SnackBar(
        content: Text(
          "درخواست با خطا مواجه شد",
          style: TextStyle(fontFamily: "Yekan", fontSize: 15),
        ),
      );
    }
  }
}
