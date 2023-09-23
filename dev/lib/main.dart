import 'package:flutter/material.dart';

const Color primaryColor = Color.fromARGB(255, 0, 255, 64);
const TargetPlatform platform = TargetPlatform.android;

void main() {
  runApp(DayPlanner());
}

class DayPlanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        useMaterial3: true,
        platform: platform,
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("📆 Day Planner"),
        ),
        drawer: Drawer(
          child: ListView(
            children: const [
              DrawerHeader(
                child: Center(
                  child: Text(
                    "Day Planner 🗓️",
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
