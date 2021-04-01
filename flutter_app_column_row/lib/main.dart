import 'package:flutter/material.dart';
import 'package:flutter_app_column_row/columnSpaceAround.dart';
import 'package:flutter_app_column_row/columnSpaceBetween.dart';
import 'package:flutter_app_column_row/columnSpaceEvenly.dart';
import 'package:flutter_app_column_row/rowSpaceAround.dart';
import 'package:flutter_app_column_row/rowSpaceBetween.dart';
import 'package:flutter_app_column_row/rowSpaceEvenly.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'What is Column and Row',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'What is Column and Row'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return ColumnSpaceAround();
                  }));
                },
                child: Text("Column SpaceAround")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return ColumnSpaceBetween();
                  }));
                },
                child: Text("Column SpaceBetween")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return ColumnSpaceEvenly();
                  }));
                },
                child: Text("Column SpaceEvenly")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return RowSpaceAround();
                  }));
                },
                child: Text("Row SpaceAround")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return RowSpaceBetween();
                  }));
                },
                child: Text("Row SpaceBetween")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return RowSpaceEvenly();
                  }));
                },
                child: Text("Row SpaceEvenly")),
          ],
        ),
      ),
    );
  }
}
