import 'package:flutter/material.dart';

class ColumnSpaceBetween extends StatefulWidget {
  @override
  _ColumnSpaceBetween createState() => _ColumnSpaceBetween();
}

class _ColumnSpaceBetween extends State<ColumnSpaceBetween> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Column SpaceBetween"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
