import 'dart:async';
import './puzzle.dart';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> insertPuzzle(Puzzle puzzle) async {
  final db = await openDatabase(
    join(await getDatabasesPath(), 'puzzle_database.db'),
  );

  await db.insert('Puzzles', puzzle.toMap());
}

Future<List<Puzzle>> puzzles() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await deleteDatabase('puzzle_database.db');

  final database = openDatabase(
    join(await getDatabasesPath(), 'puzzle_database.db'),
    version: 1,
    onUpgrade: (db, prev, current) {
      return db.execute(
        '''
          CREATE TABLE Puzzles(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            puzzle STRING NOT NULL UNIQUE,
            size INTEGER NOT NULL
          );
          CREATE TABLE Times(
            id REFERENCES Puzzles(id),
            time STRING
          );
            INSERT INTO PuzzlesS(puzzle, size) VALUES
            ("110100 101101 011110 111001 100010 101101 ", 6),
            ("101001 111011 101111 110010 011101 111011", 6),
            ("110101 101110 101100 111010 111010 101010", 6),
            ("100001 110010 110000 010111 010101 001110", 6),
            ("100111 110000 000000 001000 001100 011101", 6),
            ("001110 000010 111000 101110 101010 010000", 6),
            ("0001110 0010000 0010010 1110011 0101001 1110101 0100101", 7),
            ("1001010 1100011 1110010 0001011 1100011 1100000 0001100", 7),
            ("0010110 1011011 1101110 0000110 0110101 1111111 1001001", 7),
            ("0101000 0010001 0110001 0010001 1011100 1100001 0001000", 7),
            ("0111110 1010111 1110101 1010011 0011010 1100111 1011100", 7),
            ("0111101 0010111 0110111 0010110 1000100 1100010 1111110", 7)          
          ''',
      );
    },
  );

  final db = await database;

  final List<Map<String, Object?>> puzzleMaps = await db.query('Puzzles');

  return [
    for (final {'puzzle': puzzle as String, 'size': size as int} in puzzleMaps)
      Puzzle.fromData(puzzle, size),
  ];
}

void main() async {
  // await insertPuzzle(Puzzle(7));
  List<Puzzle> results = await puzzles();
  print('found puzzles $results');
}
