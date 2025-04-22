import 'package:flutter/material.dart';
import 'dart:math';

import 'puzzle.dart';
import 'grid_space.dart';

void main() {
  runApp(const MainApp());

  // Puzzle puzzle = Puzzle(7);
  // print(puzzle.puzzle);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: GameState());
  }
}

class GameState extends StatefulWidget {
  const GameState({super.key});

  @override
  State<GameState> createState() => _GameStateState();
}

class _GameStateState extends State<GameState> {
  final Puzzle puzzle = Puzzle(7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              return SizedBox();
            }
            // Top row; column sums
            else if (index <= puzzle.scale) {
              // print(puzzle.sums[1][index - 1]);
              return SizedBox(child: Text("${puzzle.sums[1][index - 1]}"));
            }
            // Right column; row sums
            else if (index % (puzzle.scale + 1) == 0) {
              int row = (index / (puzzle.scale + 1)).toInt() - 1;
              // print("Row: $row");
              // print(puzzle.sums[0][row]);
              return SizedBox(child: Text("${puzzle.sums[0][row]}"));
            }
            else {
              int row = (index ~/ (puzzle.scale + 1)) - 1;
              int col = (index % (puzzle.scale + 1)) - 1;
              print("($col, $row)");
              return GridSpace(col, row);
            }
            
          },
        ),
      ),
    );
  }
}
