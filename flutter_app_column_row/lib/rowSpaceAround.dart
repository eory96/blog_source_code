import 'package:flutter/material.dart';

class RowSpaceAround extends StatefulWidget {
  @override
  _RowSpaceAround createState() => _RowSpaceAround();
}

class _RowSpaceAround extends State<RowSpaceAround> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Row SpaceAround"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
