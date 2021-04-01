import 'package:flutter/material.dart';

class RowSpaceEvenly extends StatefulWidget {
  @override
  _RowSpaceEvenly createState() => _RowSpaceEvenly();
}

class _RowSpaceEvenly extends State<RowSpaceEvenly> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Row SpaceEvenly"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
