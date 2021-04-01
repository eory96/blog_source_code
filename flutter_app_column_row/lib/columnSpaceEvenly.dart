import 'package:flutter/material.dart';

class ColumnSpaceEvenly extends StatefulWidget {
  @override
  _ColumnSpaceEvenly createState() => _ColumnSpaceEvenly();
}

class _ColumnSpaceEvenly extends State<ColumnSpaceEvenly> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Column SpaceEvenly"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
