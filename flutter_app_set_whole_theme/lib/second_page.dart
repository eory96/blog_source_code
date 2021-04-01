import 'package:flutter/material.dart';

class MySecondPage extends StatefulWidget {
  _MySecondPageState createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Second page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('전체 테마를 적용한 후', style: Theme.of(context).textTheme.display1),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('이 페이지'),
            ),
          ],
        ),
      ),
    );
  }
}
