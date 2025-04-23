import 'package:flutter/material.dart';
import 'dart:math';

import 'puzzle.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final Puzzle puzzle = Puzzle(7);
  List<List<bool>> puzzleState = makeEmptyGrid(7);

  void update(int row, int col) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: puzzle.scale + 1,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              itemCount: pow((puzzle.scale + 1), 2).toInt(),
              itemBuilder: (context, index) {
                // print("index: $index");
                // Top left corner empty
                if (index == 0) {
                  return SizedBox(height: 10);
                }
                // Top row; column sums
                else if (index <= puzzle.scale) {
                  // print(puzzle.sums[1][index - 1]);
                  return SizedBox(
                    height: 10,
                    child: Text("${puzzle.sums[1][index - 1]}"),
                  );
                }
                // Right column; row sums
                else if (index % (puzzle.scale + 1) == 0) {
                  int row = (index / (puzzle.scale + 1)).toInt() - 1;
                  // print("Row: $row");
                  // print(puzzle.sums[0][row]);
                  return SizedBox(
                    height: 10,
                    child: Text("${puzzle.sums[0][row]}"),
                  );
                } else {
                  int row = (index ~/ (puzzle.scale + 1)) - 1;
                  int col = (index % (puzzle.scale + 1)) - 1;

                  // print("($col, $row)");
                  return GestureDetector(
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color:
                            puzzleState[row][col] ? Colors.black : Colors.white,
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        puzzleState[row][col] = !puzzleState[row][col];
                      });
                    },
                  );
                }
              },
            ),
      ),
    );
  }
}
