import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Theme data for light and dark themes
  final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Color.fromARGB(255, 52, 255, 93),
    platform: TargetPlatform.android,
    brightness: Brightness.light,
    useMaterial3: true,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.blue,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  );

  final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Color.fromARGB(255, 52, 255, 93),
    platform: TargetPlatform.android,
    brightness: Brightness.dark,
    useMaterial3: true,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 18, color: Colors.white),
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.blueGrey,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
  );

  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
      _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("📆 Day Planner"),
          actions: [
            IconButton(
              onPressed: _toggleTheme,
              icon: Icon(
                _themeMode == ThemeMode.light
                    ? Icons.nightlight_round
                    : Icons.wb_sunny,
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Text(
                    "Day Planner 🗓️",
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
              ListTile(
                title: Text("Day View"),
                onTap: () {
                  // Handle day view
                },
              ),
              ListTile(
                title: Text("3-Day View"),
                onTap: () {
                  // Handle 3-day view
                },
              ),
              ListTile(
                title: Text("Week View"),
                onTap: () {
                  // Handle week view
                },
              ),
              ListTile(
                title: Text("Month View"),
                onTap: () {
                  // Handle month view
                },
              ),
              Divider(), // Divider for separation
              ListTile(
                title: Text("Holidays"),
                leading: Icon(Icons.calendar_today),
                onTap: () {
                  // Handle holidays
                },
              ),
              ListTile(
                title: Text("Events"),
                leading: Icon(Icons.event),
                onTap: () {
                  // Handle events
                },
              ),
              ListTile(
                title: Text("Tasks"),
                leading: Icon(Icons.task),
                onTap: () {
                  // Handle tasks
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
