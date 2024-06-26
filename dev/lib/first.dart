// main.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'dart:collection';

import 'day_view.dart';
import 'week_view.dart';
import 'month_view.dart';
import 'second_page.dart'; // Import TaskReminderApp

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.blue, // Change to your desired primary color
  );

  final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.deepPurple, // Change to your desired primary color for dark theme
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: FirstPage(
        toggleTheme: _toggleTheme, // Pass the toggleTheme function
      ),
    );
  }

  void _toggleTheme() {
    setState(() {
      _themeMode =
      _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }
}

class FirstPage extends StatefulWidget {
  final VoidCallback toggleTheme; // Callback to toggle theme

  FirstPage({required this.toggleTheme});

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();

  LinkedHashMap<DateTime, List<Event>> events = LinkedHashMap(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  @override
  void initState() {
    super.initState();
    _generateEvents();
  }

  void _generateEvents() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🗓️ Day Planner'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Handle account button press
            },
          ),
        ],
      ),
      drawer: AppDrawer(toggleTheme: widget.toggleTheme),
      body: Container(
        child: Column(
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
              rowHeight: 30,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => TaskReminderApp()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }
}

class AppDrawer extends StatelessWidget {
  final VoidCallback toggleTheme;

  const AppDrawer({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).appBarTheme?.backgroundColor,
        height: MediaQuery.of(context).size.height * 0.8,
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
            DrawerItem(title: "Day View", onTap: () => _navigateTo(context, DayView())),
            DrawerItem(title: "Week View", onTap: () => _navigateTo(context, WeekView())),
            DrawerItem(title: "Month View", onTap: () => _navigateTo(context, MonthView())),
            Divider(),
            CheckboxItem(title: "Holidays"),
            CheckboxItem(title: "Events"),
            CheckboxItem(title: "Tasks"),
            ListTile(
              title: Text("Toggle Theme"),
              leading: Icon(Icons.brightness_4),
              onTap: toggleTheme,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const DrawerItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
    );
  }
}

class CheckboxItem extends StatelessWidget {
  final String title;

  const CheckboxItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Checkbox(
        value: false, // Replace with the checkbox value
        onChanged: (value) {
          // Handle checkbox change
        },
      ),
    );
  }
}

class Event {
  final String title;
  final DateTime date;

  Event(this.title, this.date);
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
