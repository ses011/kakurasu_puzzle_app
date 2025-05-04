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

Future<List<Map<String, Object?>>> puzzles() async {
  final db = await openDatabase(
    join(await getDatabasesPath(), 'puzzle_database.db'),
  );

  final List<Map<String, Object?>> puzzleMaps = await db.query('Puzzles');

  return [for (Map<String, Object?> puzzle in puzzleMaps) puzzle];
}

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
          );
          CREATE TABLE Times(
            id REFERENCES Puzzles(id),
            time STRING
          );
          ''');
    },
  );

  await insertPuzzle(Puzzle(7));
  List<Map<String, Object?>> results = await puzzles();
  print('found puzzles $results');
}
