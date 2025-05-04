import 'dart:async' show Timer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'puzzle.dart';

class GamePage extends StatefulWidget {
  final Puzzle puzzle;
  final bool random;
  const GamePage(this.puzzle, this.random, {super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late List<List<bool>> puzzleState;
  late Stopwatch stopwatch;
  late Timer t;

  @override
  void initState() {
    super.initState();
    puzzleState = makeEmptyGrid(widget.puzzle.scale);

    print(puzzleState);
    print(widget.puzzle);
    
    stopwatch = Stopwatch();
    t = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {});
    });

    stopwatch.start();
  }

  bool checkAccuracy() {
    for (int row = 0; row < widget.puzzle.puzzle.length; row++) {
      if (!listEquals(widget.puzzle.puzzle[row], puzzleState[row])) {
        return false;
      }
    }

    t.cancel();
    stopwatch.stop();
    return true;
  }

  void popup(bool random) {
    showDialog<void>(
      context: (context),
      builder: (context) {
        return AlertDialog(
          title: Text("Success!"),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // Close popup
                Navigator.pop(context); // Close popup
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GamePage(Puzzle.random(), true)),
                );
              },
              child: Container(
                decoration: BoxDecoration(color: Colors.amber),
                child: Text("Play again"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // Close popup
                Navigator.pop(
                  context,
                ); // Return home if random, goes back to list if not
                if (!random) {
                  Navigator.pop(context); // Return home
                }
              },
              child: Container(
                decoration: BoxDecoration(color: Colors.amber),
                child: Text("Home"),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            t.cancel();
            stopwatch.stop();
            Navigator.pop(context);
          },
          icon: const BackButtonIcon(),
        ),
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(stopwatch.elapsed.toString()),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.puzzle.scale + 1,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
          ),
          itemCount: pow((widget.puzzle.scale + 1), 2).toInt(),
          itemBuilder: (context, index) {
            // print("index: $index");
            // Top left corner empty
            if (index == 0) {
              return SizedBox(height: 10);
            }
            // Top row; column sums
            else if (index <= widget.puzzle.scale) {
              // print(puzzle.sums[1][index - 1]);
              return SizedBox(
                height: 10,
                child: Text(
                  "${widget.puzzle.sums[1][index - 1]}",
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
              );
            }
            // Right column; row sums
            else if (index % (widget.puzzle.scale + 1) == 0) {
              int row = (index / (widget.puzzle.scale + 1)).toInt() - 1;
              // print("Row: $row");
              // print(puzzle.sums[0][row]);
              return SizedBox(
                height: 10,
                child: Text(
                  "${widget.puzzle.sums[0][row]}",
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              int row = (index ~/ (widget.puzzle.scale + 1)) - 1;
              int col = (index % (widget.puzzle.scale + 1)) - 1;

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
                    if (checkAccuracy()) {
                      popup(widget.random);
                    }
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
