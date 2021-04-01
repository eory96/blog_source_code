import 'package:flutter/material.dart';

class RowSpaceBetween extends StatefulWidget {
  @override
  _RowSpaceBetween createState() => _RowSpaceBetween();
}

class _RowSpaceBetween extends State<RowSpaceBetween> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Row SpaceBetween"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 50,
            color: Colors.red,
          ),
          Container(
            width: 50,
            color: Colors.orange,
          ),
          Container(
            width: 50,
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }
}
