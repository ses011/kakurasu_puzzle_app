import 'dart:math';

class Puzzle {
  List<List<bool>> puzzle = [];
  List<List<int>> sums = []; // 0: rows, 1: columns
  int scale;

  Puzzle(this.scale) {
    scale = scale;
    int count = 0;
    puzzle = makeEmptyGrid(scale);

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

      // print("x: $x\ty: $y");

      if (!puzzle[y][x]) {
        puzzle[y][x] = true;
        squares++;
      }
    }

    findSums();
  }

  Puzzle.random() : this(7);

  Puzzle.fromData(String puzzleString, this.scale) {
    List<String> splitRows = puzzleString.split(" ");
    for (String rowString in splitRows) {
      List<bool> row = [];
      List<String> splitGrid = rowString.split("");
      for (String box in splitGrid) {
        row.add(box == "1");
      }
      puzzle.add(row);
    }

    findSums();
  }

  void findSums() {
    // Get row and column totals
    List<int> rowSums = [];
    List<int> colSums = [];
    for (int i = 0; i < scale; i++) {
      int row = 0;
      int col = 0;
      for (int j = 0; j < scale; j++) {
        if (puzzle[i][j]) {
          row += (j + 1);
        }
        if (puzzle[j][i]) {
          col += (j + 1);
        }
      }
      rowSums.add(row);
      colSums.add(col);
    }

    sums.add(rowSums);
    sums.add(colSums);
  }

  Map<String, Object?> toMap() {
    return {'puzzle': toString(), 'size': scale};
  }

  @override
  String toString() {
    String puzzleString = "";
    for (int i = 0; i < scale; i++) {
      for (int j = 0; j < scale; j++) {
        if (puzzle[i][j]) {
          puzzleString += '1';
        } else {
          puzzleString += '0';
        }
      }
      puzzleString += " ";
    }
    return puzzleString;
  }
}

/// makeEmptyGrid
/// make puzzle a scale x scale 2D array filled with only 'false'
List<List<bool>> makeEmptyGrid(int scale) {
  List<List<bool>> empty = [];
  for (int i = 0; i < scale; i++) {
    empty.add(List<bool>.filled(scale, false));
  }
  return empty;
}

void main() {
  Puzzle puzzle = Puzzle.random();

  print('puzzle: ${puzzle.toString()}');
  // Map<String, Object?> map = puzzle.toMap();
  // print(map);

  // Puzzle newPuzzle = Puzzle.fromData(map['puzzle'].toString(), int.parse(map['size'].toString()));
  // print(newPuzzle.puzzle);
  // print(puzzle.sums);
}
