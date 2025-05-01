import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './gamePage.dart';
import './puzzle.dart';
import './data.dart' as Data;

class Puzzlelist extends StatefulWidget {
  const Puzzlelist({super.key});

  @override
  State<Puzzlelist> createState() => _PuzzlelistState();
}

class _PuzzlelistState extends State<Puzzlelist> {
  List<Map<String, Object?>> puzzles = [{}];

  Future<void> getData() async {
    setState(() async {
      puzzles = await Data.puzzles();
    });
  }

  Future<List<Map<String, Object?>>> checkPuzzles() async {
    for (Map<String, Object?> puzzle in puzzles) {
      if (puzzle['id'] != null) {}
    }
    return puzzles;
  }

  @override
  void initState() {
    super.initState();
    getData();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const BackButtonIcon(),
        ),
      ),
      body: FutureBuilder(
        future: checkPuzzles(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: puzzles.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Container(decoration: BoxDecoration()),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GamePage()),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
