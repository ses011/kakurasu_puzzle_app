
import 'dart:math';

class Puzzle {
  List<List<bool>> puzzle = [];
  List<List<int>> sums = []; // 0: rows, 1: columns
  int scale;

  Puzzle(this.scale) {
    scale = scale;
    int count = 0;
    makeEmptyGrid();

    // Gets a number so that each row or column will (in theory) have
    // [1, scale -1] number of boxes to fill
    // Theory depends on randomization but full/empty rows are ok
    for (int i = 0; i < scale; i++) {
      count += Random().nextInt(scale - 1) + 1; 
    }    

    // Randomly fill puzzle array to generate the puzzle
    int squares = 0; // counter of squares filled
    while (squares < count) {
      int x = Random().nextInt(scale);
      int y = Random().nextInt(scale);

      print("x: $x\ty: $y");

      if (!puzzle[y][x]) {
        puzzle[y][x] = true;
        squares++;
      }
    }

    // Get row and column totals
    List<int> rowSums = [];
    for (int i = 0; i < scale; i++) {
      for (bool item in puzzle[i]) {

      }
    }
  }

  /// makeEmptyGrid
  /// make puzzle a scale x scale 2D array filled with only 'false' 
  void makeEmptyGrid() {
    for (int i = 0; i < scale; i++) {
      puzzle.add(List<bool>.filled(scale, false));
    }
  }
}

void main() {
  Puzzle puzzle = Puzzle(7);
  print(puzzle.puzzle);
  print(puzzle.sums);
}