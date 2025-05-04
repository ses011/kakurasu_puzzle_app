import 'dart:async';

import 'package:flutter/material.dart';

import './gamePage.dart';
import './puzzle.dart';
import './data.dart' as data;

class Puzzlelist extends StatefulWidget {
  const Puzzlelist({super.key});

  @override
  State<Puzzlelist> createState() => _PuzzlelistState();
}

class _PuzzlelistState extends State<Puzzlelist> {
  List<Puzzle> puzzles = [];

  Future<void> getData() async {
    puzzles = await data.puzzles();
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
                child: Row(
                  children: [
                    Text(
                      (index + 1).toString(),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Text("\n\t${puzzles[index].scale}x${puzzles[index].scale}"),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GamePage(puzzles[index], false),
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
