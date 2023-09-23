import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      backgroundColor: Colors.blue, // Use backgroundColor instead of color
      iconTheme: IconThemeData(color: Colors.white),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  );

  final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Color.fromARGB(255, 255, 0, 0),
    platform: TargetPlatform.android,
    brightness: Brightness.dark,
    useMaterial3: true,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 18, color: Colors.white),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue, // Use backgroundColor instead of color
      iconTheme: IconThemeData(color: Colors.white),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 255, 255)),
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
          title: Text("📆 Month Name Here"), // Replace with your month name
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle), // Account icon
              onPressed: () {
                // Handle account button press
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: Container(
            color: darkTheme.appBarTheme.backgroundColor, // Use backgroundColor instead of color
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
                Divider(),
                ListTile(
                  title: Text("Holidays"),
                  leading: Checkbox(
                    value: false, // Replace with the holiday checkbox value
                    onChanged: (value) {
                      // Handle holiday checkbox
                    },
                  ),
                ),
                ListTile(
                  title: Text("Events"),
                  leading: Checkbox(
                    value: false, // Replace with the events checkbox value
                    onChanged: (value) {
                      // Handle events checkbox
                    },
                  ),
                ),
                ListTile(
                  title: Text("Tasks"),
                  leading: Checkbox(
                    value: false, // Replace with the tasks checkbox value
                    onChanged: (value) {
                      // Handle tasks checkbox
                    },
                  ),
                ),
                ListTile(
                  title: Text("Toggle Theme"),
                  leading: Icon(Icons.brightness_4), // Moon icon for theme toggle
                  onTap: _toggleTheme, // Toggle theme function
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Handle adding tasks
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
