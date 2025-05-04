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
    puzzles = await Data.puzzles();
    setState(() {});
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
      body: ListView.builder(
        itemCount: puzzles.length,
        itemBuilder: (context, index) {
          if (puzzles.isEmpty) {
            return SizedBox(child: Icon(Icons.leak_add_rounded));
          } else {
            return GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 4),
                ),
                child: Row(children: [Text(index.toString())]),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => GamePage(
                          Puzzle.fromData(
                            puzzles[index]['puzzle'] as String,
                            puzzles[index]['size'] as int,
                          ),
                          false,
                        ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
