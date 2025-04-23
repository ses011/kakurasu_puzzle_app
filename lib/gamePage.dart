import 'dart:async' show Timer;

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
  late Stopwatch stopwatch;
  late Timer t;

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();
    t = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
    stopwatch.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: BackButton(
          onPressed: () {
            t.cancel();
            stopwatch.stop();
            Navigator.pop(context);
          },
        ),
        title: Align(alignment: Alignment.centerRight, child: Text(stopwatch.elapsed.toString())),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
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
                child: Text(
                  "${puzzle.sums[1][index - 1]}",
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
              );
            }
            // Right column; row sums
            else if (index % (puzzle.scale + 1) == 0) {
              int row = (index / (puzzle.scale + 1)).toInt() - 1;
              // print("Row: $row");
              // print(puzzle.sums[0][row]);
              return SizedBox(
                height: 10,
                child: Text(
                  "${puzzle.sums[0][row]}",
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              int row = (index ~/ (puzzle.scale + 1)) - 1;
              int col = (index % (puzzle.scale + 1)) - 1;

              // print("($col, $row)");
              return GestureDetector(
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: puzzleState[row][col] ? Colors.black : Colors.white,
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
