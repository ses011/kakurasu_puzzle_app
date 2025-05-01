import 'package:flutter/material.dart';

import 'puzzleList.dart';
import 'puzzle.dart';
import 'gamePage.dart';

void main() {
  runApp(const MainApp());

  // Puzzle puzzle = Puzzle(7);
  // print(puzzle.puzzle);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(centerTitle: false),
        textTheme: TextTheme(displayLarge: TextStyle(color: Colors.amber)),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Kakurasu",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          SizedBox(height: 500),

          Container(
            padding: EdgeInsets.all(10),
            height: 100,
            width: MediaQuery.sizeOf(context).width,
            child: GridView.count(
              crossAxisSpacing: 5,
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GamePage()),
                    );
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(color: Colors.green),
                    child: Text(
                      "Speed",
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Puzzlelist()),
                    );
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(color: Colors.lightBlueAccent),
                    // child: Text("Speed"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
