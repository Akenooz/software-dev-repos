import 'package:flutter/material.dart';

const Color primaryColor = Color.fromARGB(255, 0, 255, 64);
const TargetPlatform platform = TargetPlatform.android;

void main() {
  runApp(DayPlanner());
}

class DayPlannerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // This painter is empty, so it won't draw anything.
  }

  @override
  bool shouldRepaint(DayPlannerPainter oldDelegate) {
    return false; // No need to repaint
  }
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
          title: const Text("Day Planner"),
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
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
            ),
          ),
          child: Center(
            child: SizedBox(
              width: 400,
              height: 400,
              child: CustomPaint(
                painter: DayPlannerPainter(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
