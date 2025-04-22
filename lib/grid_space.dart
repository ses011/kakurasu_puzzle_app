import 'package:flutter/material.dart';

class GridSpace extends StatefulWidget {
  final int col;
  final int row;

  const GridSpace(this.col, this.row, {super.key});

  @override
  State<GridSpace> createState() => _CreateGridSpace();
}

class _CreateGridSpace extends State<GridSpace> {
  bool state = false;

  Widget build(BuildContext context) {
    return Container(
      width: 5,
      height: 5,
      decoration: BoxDecoration(
        color: state ? Colors.black : Colors.white,
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            state = !state;
          });
        },
      ),
    );
  }
}
