import 'dart:async';
import './puzzle.dart';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(
    join(await getDatabasesPath(), 'puzzle_database.db'),
    version: 1,
    onCreate: (db, version) {
      return db.execute('''
          CREATE TABLE Puzzles(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            puzzle STRING NOT NULL UNIQUE,
            size INTEGER NOT NULL
          );''');
    },
  );



  Future<void> insertPuzzle(Puzzle puzzle) async {
    final db = await database;

    await db.insert('Puzzles', puzzle.toMap());
  }

  Future<List<Puzzle>> puzzles() async {
    final db = await database;

    final List<Map<String, Object?>> puzzleMaps = await db.query('Puzzles');

    return [
      for (final {'puzzle': puzzle as String, 'size': size as int}
          in puzzleMaps)
        Puzzle.fromData(puzzle, size),
    ];
  }

  await insertPuzzle(Puzzle(7));
  List<Puzzle> results = await puzzles();
  print('found puzzles $results');




  // Future<void> makeTimeTable() async {
  //   final db = await database;
  //   await db.execute('''
  //       CREATE TABLE Times(
  //         id REFERENCES Puzzles(id),
  //         time STRING
  //       ); ''');
  // }
  // await makeTimeTable();

}
