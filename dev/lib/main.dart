import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'dart:collection';

void main() {
  runApp(MyApp());
}

class Event {
  final String title;
  final DateTime date;

  Event(this.title, this.date);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  LinkedHashMap<DateTime, List<Event>> events = LinkedHashMap(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  // Define light and dark themes
  final ThemeData lightTheme = ThemeData.light().copyWith(
    // Configure the light theme here
  );

  final ThemeData darkTheme = ThemeData.dark().copyWith(
    // Configure the dark theme here
  );

  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
      _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  void initState() {
    super.initState();
    _generateEvents();
  }

  // Generate example events
  void _generateEvents() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final oneDay = Duration(days: 1);

    events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );

    for (int i = 0; i < 5; i++) {
      final day = today.add(Duration(days: i));
      final eventsForDay = <Event>[
        Event('Event 1', day.add(Duration(hours: 9))),
        Event('Event 2', day.add(Duration(hours: 14))),
      ];

      events[day] = eventsForDay;
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
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
            height: MediaQuery.of(context).size.height * 0.8, // Adjust the height here
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
        body: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay ?? selectedDay;
                });
              },
              eventLoader: (day) {
                return _getEventsForDay(day);
              },
              rowHeight: 30, // Adjust the row height to decrease both vertical and horizontal space
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
                weekendStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.red,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _getEventsForDay(_selectedDay).length,
                itemBuilder: (context, index) {
                  final event = _getEventsForDay(_selectedDay)[index];
                  return ListTile(
                    title: Text(event.title),
                    subtitle: Text(DateFormat('hh:mm a').format(event.date)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// A function to generate a unique hash code for a DateTime
int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
