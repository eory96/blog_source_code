import 'package:flutter/material.dart';

import 'first_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.deepOrange,
        ),
        textTheme: TextTheme(
          display1: TextStyle(
            fontSize: 30,
            color: Colors.deepOrange,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.deepOrange,
        ),
      ),
      home: MyFirstPage(),
    );
  }
}
