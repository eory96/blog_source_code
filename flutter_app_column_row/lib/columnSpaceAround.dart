import 'package:flutter/material.dart';

class ColumnSpaceAround extends StatefulWidget {
  @override
  _ColumnSpaceAround createState() => _ColumnSpaceAround();
}

class _ColumnSpaceAround extends State<ColumnSpaceAround> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Column SpaceAround"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 100,
            color: Colors.red,
          ),
          Container(
            height: 100,
            color: Colors.orange,
          ),
          Container(
            height: 100,
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }
}
