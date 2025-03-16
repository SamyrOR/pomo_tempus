import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Icon(Icons.settings),
              iconSize: 32,
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.timer),
          // Icon(Icons.free_breakfast),
          Text("25:00", style: TextStyle(fontSize: 64)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 68),
              IconButton(
                icon: Icon(Icons.play_arrow),
                iconSize: 32,
                onPressed: () {},
              ),
              // IconButton(
              //   icon: Icon(Icons.pause),
              //   iconSize: 32,
              //   onPressed: () {},
              // ),
              IconButton(
                icon: Icon(Icons.skip_next),
                iconSize: 32,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 64),
        ],
      ),
    );
  }
}
